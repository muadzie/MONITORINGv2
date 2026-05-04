-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 04, 2026 at 08:13 AM
-- Server version: 8.4.3
-- PHP Version: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `monitoring_pkl`
--

-- --------------------------------------------------------

--
-- Table structure for table `assessments`
--

CREATE TABLE `assessments` (
  `id` bigint UNSIGNED NOT NULL,
  `student_id` bigint UNSIGNED NOT NULL,
  `assessor_id` bigint UNSIGNED NOT NULL,
  `assessor_type` enum('guru','perusahaan') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'guru',
  `attendance_score` int DEFAULT NULL,
  `logbook_score` int DEFAULT NULL,
  `report_score` int DEFAULT NULL,
  `attitude_score` int DEFAULT NULL,
  `performance_score` int DEFAULT NULL,
  `discipline_score` int DEFAULT NULL,
  `final_score` decimal(5,2) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `assessments`
--

INSERT INTO `assessments` (`id`, `student_id`, `assessor_id`, `assessor_type`, `attendance_score`, `logbook_score`, `report_score`, `attitude_score`, `performance_score`, `discipline_score`, `final_score`, `notes`, `created_at`, `updated_at`) VALUES
(1, 10, 2, 'guru', 100, 3, 100, 100, 100, NULL, 71.00, NULL, '2026-04-28 21:52:15', '2026-04-28 22:01:35');

-- --------------------------------------------------------

--
-- Table structure for table `attendances`
--

CREATE TABLE `attendances` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `company_id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `check_in` time DEFAULT NULL,
  `check_out` time DEFAULT NULL,
  `check_in_lat` decimal(10,8) DEFAULT NULL,
  `check_in_lng` decimal(11,8) DEFAULT NULL,
  `check_out_lat` decimal(10,8) DEFAULT NULL,
  `check_out_lng` decimal(11,8) DEFAULT NULL,
  `status` enum('present','late','absent','sick','permit') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'absent',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_valid_location` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attendances`
--

INSERT INTO `attendances` (`id`, `user_id`, `company_id`, `date`, `check_in`, `check_out`, `check_in_lat`, `check_in_lng`, `check_out_lat`, `check_out_lng`, `status`, `notes`, `photo`, `is_valid_location`, `created_at`, `updated_at`) VALUES
(1, 10, 1, '2026-04-29', '00:54:01', '00:54:21', -6.57829150, 107.78331400, -6.57827465, 107.78308558, 'present', NULL, NULL, 0, '2026-04-28 17:54:01', '2026-04-28 17:54:21'),
(2, 10, 1, '2026-04-30', NULL, NULL, NULL, NULL, NULL, NULL, 'sick', 'Izin/Sakit: ss', NULL, 0, '2026-04-29 20:12:56', '2026-04-29 20:12:56'),
(3, 11, 1, '2026-04-29', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-04-29 20:30:24', '2026-04-29 20:30:24'),
(4, 12, 2, '2026-04-29', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-04-29 20:30:24', '2026-04-29 20:30:24'),
(5, 13, 6, '2026-04-29', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-04-29 20:30:24', '2026-04-29 20:30:24'),
(6, 14, 6, '2026-04-29', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-04-29 20:30:24', '2026-04-29 20:30:24'),
(7, 15, 6, '2026-04-29', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-04-29 20:30:24', '2026-04-29 20:30:24'),
(8, 16, 6, '2026-04-29', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-04-29 20:30:24', '2026-04-29 20:30:24'),
(9, 17, 6, '2026-04-29', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-04-29 20:30:24', '2026-04-29 20:30:24'),
(10, 18, 5, '2026-04-29', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-04-29 20:30:24', '2026-04-29 20:30:24'),
(11, 19, 5, '2026-04-29', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-04-29 20:30:24', '2026-04-29 20:30:24'),
(12, 20, 3, '2026-04-29', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-04-29 20:30:24', '2026-04-29 20:30:24'),
(13, 21, 3, '2026-04-29', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-04-29 20:30:24', '2026-04-29 20:30:24'),
(14, 22, 6, '2026-04-29', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-04-29 20:30:25', '2026-04-29 20:30:25'),
(15, 23, 4, '2026-04-29', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-04-29 20:30:25', '2026-04-29 20:30:25'),
(16, 24, 5, '2026-04-29', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-04-29 20:30:25', '2026-04-29 20:30:25'),
(17, 25, 5, '2026-04-29', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-04-29 20:30:25', '2026-04-29 20:30:25');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jurusan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tingkat` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `teacher_id` bigint UNSIGNED DEFAULT NULL,
  `academic_year` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`id`, `name`, `jurusan`, `tingkat`, `teacher_id`, `academic_year`, `created_at`, `updated_at`) VALUES
(1, 'TP 1', 'Teknik Pemesinan', '12', 2, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(2, 'TP 2', 'Teknik Pemesinan', '12', 2, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(3, 'TP 3', 'Teknik Pemesinan', '12', 2, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(4, 'DG 1', 'Desain Grafika', '12', NULL, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(5, 'DG 2', 'Desain Grafika', '12', NULL, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(6, 'TL 1', 'Teknik Logistik', '12', NULL, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(7, 'TL 2', 'Teknik Logistik', '12', NULL, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(8, 'TBSM 1', 'Teknik dan Bisnis Sepeda Motor', '12', NULL, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(9, 'TBSM 2', 'Teknik dan Bisnis Sepeda Motor', '12', NULL, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(10, 'TBSM 3', 'Teknik dan Bisnis Sepeda Motor', '12', NULL, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(11, 'RPL 1', 'Rekayasa Perangkat Lunak', '12', 3, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(12, 'RPL 2', 'Rekayasa Perangkat Lunak', '12', 3, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(13, 'RPL 3', 'Rekayasa Perangkat Lunak', '12', 3, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(14, 'TKJ 1', 'Teknik Komputer dan Jaringan', '12', 4, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(15, 'TKJ 2', 'Teknik Komputer dan Jaringan', '12', 4, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(16, 'TKJ 3', 'Teknik Komputer dan Jaringan', '12', 4, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(17, 'BDP 1', 'Bisnis Daring dan Pemasaran', '12', NULL, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(18, 'BDP 2', 'Bisnis Daring dan Pemasaran', '12', NULL, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(19, 'OTKP 1', 'Otomatisasi dan Tata Kelola Perkantoran', '12', NULL, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(20, 'OTKP 2', 'Otomatisasi dan Tata Kelola Perkantoran', '12', NULL, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(21, 'AKL 1', 'Akuntansi dan Keuangan Lembaga', '12', 5, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(22, 'AKL 2', 'Akuntansi dan Keuangan Lembaga', '12', 5, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(23, 'TB 1', 'Tata Boga', '12', 6, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(24, 'TB 2', 'Tata Boga', '12', 6, '2025/2026', '2026-04-27 23:12:40', '2026-04-27 23:12:40');

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `radius` int NOT NULL DEFAULT '100',
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `name`, `address`, `phone`, `email`, `latitude`, `longitude`, `radius`, `description`, `created_at`, `updated_at`) VALUES
(1, 'PT. Honda Prospect Motor', 'Subang, West Java, Java, 41215, Indonesia', '021-89891234', 'info@honda.co.id', -6.57861901, 107.78356075, 150, 'Perusahaan manufaktur otomotif terkemuka', '2026-04-27 23:12:40', '2026-04-28 18:50:49'),
(2, 'PT. Toyota Manufacturing Indonesia', 'Jl. Yos Sudarso, Sunter, Jakarta Utara', '021-65308888', 'info@toyota.co.id', -6.12500000, 106.89050000, 200, 'Perusahaan manufaktur otomotif', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(3, 'PT. Unilever Indonesia Tbk', 'Jl. Jenderal Sudirman Kav 15, Jakarta', '021-52381234', 'info@unilever.co.id', -6.21500000, 106.80250000, 100, 'Perusahaan consumer goods', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(4, 'PT. Pertamina (Persero)', 'Jl. Medan Merdeka Timur, Jakarta Pusat', '021-3816111', 'info@pertamina.com', -6.17500000, 106.82250000, 250, 'Perusahaan energi dan logistik', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(5, 'PT. Bank Mandiri Tbk', 'Jl. Jenderal Gatot Subroto Kav 36-38, Jakarta', '021-52997777', 'info@bankmandiri.co.id', -6.22500000, 106.80250000, 100, 'Bank terbesar di Indonesia', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(6, 'PT. Gojek Indonesia', 'Jl. Kemang Raya No 10, Jakarta Selatan', '021-29035222', 'info@gojek.com', -6.26500000, 106.82500000, 150, 'Perusahaan teknologi transportasi', '2026-04-27 23:12:40', '2026-04-27 23:12:40');

-- --------------------------------------------------------

--
-- Table structure for table `final_reports`
--

CREATE TABLE `final_reports` (
  `id` bigint UNSIGNED NOT NULL,
  `student_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abstract` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('draft','submitted','reviewing','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `revision_notes` text COLLATE utf8mb4_unicode_ci,
  `reviewer_id` bigint UNSIGNED DEFAULT NULL,
  `submitted_at` timestamp NULL DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `logbooks`
--

CREATE TABLE `logbooks` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `activity` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `grade` int DEFAULT NULL,
  `feedback` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `logbooks`
--

INSERT INTO `logbooks` (`id`, `user_id`, `date`, `activity`, `description`, `attachment`, `status`, `grade`, `feedback`, `created_at`, `updated_at`) VALUES
(1, 10, '2026-04-29', 'ss', 'ss', 'logbooks/logbook_10_1777432919.png', 'approved', 100, NULL, '2026-04-28 20:22:00', '2026-04-30 17:42:50');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2026_04_16_130111_create_personal_access_tokens_table', 1),
(2, '2026_04_16_131725_create_roles_table', 1),
(3, '2026_04_16_132130_create_companies_table', 1),
(4, '2026_04_16_132200_create_users_table', 1),
(5, '2026_04_16_132210_create_attendances_table', 1),
(6, '2026_04_16_132242_create_logbooks_table', 1),
(7, '2026_04_16_132310_create_permissions_table', 1),
(8, '2026_04_16_144007_create_sessions_table', 1),
(9, '2026_04_16_174224_create_placement_table', 1),
(10, '2026_04_17_161938_create_reports_table', 1),
(11, '2026_04_18_014222_add_radius_to_companies_table', 1),
(12, '2026_04_18_014311_add_photo_to_attendances_table', 1),
(13, '2026_04_18_014337_create_assessments_table', 1),
(14, '2026_04_18_014418_create_notifications_table', 1),
(15, '2026_04_18_014455_create_final_reports_table', 1),
(16, '2026_04_18_022146_add_registration_fields_to_users_table', 1),
(17, '2026_04_18_023415_add_is_active_to_users_table', 1),
(18, '2026_04_22_024624_create_cache_table', 1),
(19, '2026_04_22_062548_add_teacher_fields_to_users_table', 1),
(20, '2026_04_22_065247_add_phone_email_to_companies_table', 1),
(21, '2026_04_22_071357_create_classes_table', 1),
(22, '2026_04_22_071511_add_class_id_to_users_table', 1),
(23, '2026_04_22_073759_add_class_id_to_users_table', 1),
(24, '2026_04_22_073948_add_notes_to_placements_table', 1),
(25, '2026_04_22_075525_add_jurusan_and_tingkat_to_classes_table', 1),
(26, '2026_04_28_065300_add_teacher_id_to_placements_table', 2),
(27, '2026_04_29_003243_add_notes_to_reports_table', 3),
(28, '2026_04_29_041240_add_feedback_to_permissions_table', 4);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'info',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `title`, `message`, `type`, `url`, `is_read`, `created_at`, `updated_at`) VALUES
(1, 2, 'Siswa Check In', 'Ahmad Fauzi telah melakukan check in PKL', 'info', NULL, 0, '2026-04-28 17:54:01', '2026-04-28 17:54:01');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `type` enum('sick','permit') COLLATE utf8mb4_unicode_ci NOT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `feedback` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `user_id`, `date`, `type`, `reason`, `attachment`, `status`, `feedback`, `created_at`, `updated_at`) VALUES
(1, 10, '2026-04-29', 'sick', 'demam', 'permissions/permission_10_1777435813.png', 'approved', NULL, '2026-04-28 21:10:13', '2026-04-28 21:13:39'),
(2, 10, '2026-04-30', 'sick', 'ss', NULL, 'approved', NULL, '2026-04-29 20:03:50', '2026-04-29 20:04:24');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth-token', 'dfd058840698a7a79270c878ea943a845d02310034f2cdd2e7c1566d1ee13775', '[\"*\"]', '2026-04-27 23:55:32', NULL, '2026-04-27 23:13:06', '2026-04-27 23:55:32'),
(2, 'App\\Models\\User', 10, 'auth-token', '3da63ba752180febdcf84542842cae17392f2bdc45f8556f4c9005efde1b14ad', '[\"*\"]', '2026-04-28 00:19:38', NULL, '2026-04-27 23:55:59', '2026-04-28 00:19:38'),
(3, 'App\\Models\\User', 2, 'auth-token', '0dcc1b7298a1b9d545cccf1a76d113e623522c6a5f7f5b624d78208f296b6455', '[\"*\"]', '2026-04-28 00:20:02', NULL, '2026-04-28 00:19:57', '2026-04-28 00:20:02'),
(4, 'App\\Models\\User', 1, 'auth-token', '3932235f59b623b853ad89f150a221334de84597f70d3cdfd073e7f387693c83', '[\"*\"]', '2026-04-28 01:27:12', NULL, '2026-04-28 01:20:57', '2026-04-28 01:27:12'),
(5, 'App\\Models\\User', 1, 'auth-token', '09c98eb0b971a942059c783e571072df00c7265e412794ae0100370a89b71036', '[\"*\"]', '2026-04-28 01:28:18', NULL, '2026-04-28 01:27:47', '2026-04-28 01:28:18'),
(6, 'App\\Models\\User', 10, 'auth-token', '77531f66f7ae62eac63d49ac2c4401d61f1e7b8145c6861bcca5e9e3466044d1', '[\"*\"]', '2026-04-28 03:48:16', NULL, '2026-04-28 01:28:25', '2026-04-28 03:48:16'),
(7, 'App\\Models\\User', 1, 'auth-token', 'c87c0e31e4498d176e4eca47c8d81ad044a9f0f8a8088d26a8ff893c528a6a49', '[\"*\"]', '2026-04-30 20:42:18', NULL, '2026-04-28 03:48:52', '2026-04-30 20:42:18'),
(8, 'App\\Models\\User', 10, 'auth-token', '6ae0c6dfdcb893663be94fc891056a22ab386d4f95441530566012d3e1124298', '[\"*\"]', '2026-04-28 17:25:33', NULL, '2026-04-28 16:56:15', '2026-04-28 17:25:33'),
(9, 'App\\Models\\User', 2, 'auth-token', '80fead6313f06cfe5fa0203550f31195431305046cf36d177c61762d9f109190', '[\"*\"]', '2026-04-28 17:31:48', NULL, '2026-04-28 17:01:43', '2026-04-28 17:31:48'),
(10, 'App\\Models\\User', 10, 'auth-token', '42a6d968e2408c4885156e7e088c8f5c9b642f2be8ad13f13ca104adba81517b', '[\"*\"]', '2026-04-28 18:47:49', NULL, '2026-04-28 17:35:21', '2026-04-28 18:47:49'),
(11, 'App\\Models\\User', 2, 'auth-token', 'e604684d55d01cc4820f4217e6f399090b529fd6d1e6a43cb2833b1677df7a82', '[\"*\"]', '2026-04-30 17:54:53', NULL, '2026-04-28 17:35:47', '2026-04-30 17:54:53'),
(12, 'App\\Models\\User', 10, 'auth-token', '655b0410928b53217ec1e3bbf42e5a56c5b36289e5545c65fb906d3e26323ea1', '[\"*\"]', '2026-04-30 17:12:51', NULL, '2026-04-28 18:48:15', '2026-04-30 17:12:51'),
(13, 'App\\Models\\User', 100, 'auth-token', '9ccd9ffe6965f10e6e2651610df32e0b600f68e0bf43b88d4cc45a848eb64acd', '[\"*\"]', '2026-04-30 18:25:38', NULL, '2026-04-30 17:13:24', '2026-04-30 18:25:38'),
(14, 'App\\Models\\User', 16, 'auth-token', '244e00e1d5b982da199be388447dbc0d175d4ddb19d90104582e48d04b77f208', '[\"*\"]', '2026-04-30 18:31:25', NULL, '2026-04-30 18:25:46', '2026-04-30 18:31:25'),
(15, 'App\\Models\\User', 4, 'auth-token', 'c34ac392445859b43846fc5d7aacd432997aa70164b20eb1f7758f8e09fe75b9', '[\"*\"]', '2026-04-30 21:09:02', NULL, '2026-04-30 18:31:52', '2026-04-30 21:09:02'),
(16, 'App\\Models\\User', 100, 'auth-token', '328c3783fd68fd0da1020e7f147fce5cebff7d43c4f79a0213be7ba675dc0e01', '[\"*\"]', '2026-04-30 20:44:17', NULL, '2026-04-30 20:42:45', '2026-04-30 20:44:17'),
(17, 'App\\Models\\User', 1, 'auth-token', 'e9be9b0c164f5dfc2f0d7fd0454508c316e618733d5904881acfb8f90ffc872c', '[\"*\"]', '2026-04-30 20:45:09', NULL, '2026-04-30 20:44:28', '2026-04-30 20:45:09'),
(18, 'App\\Models\\User', 10, 'auth-token', 'dd70d99d1fda366ca3e94d5c23b00a2150b34eac904a0707024dd1ab1b158f2e', '[\"*\"]', '2026-04-30 20:47:05', NULL, '2026-04-30 20:45:26', '2026-04-30 20:47:05'),
(19, 'App\\Models\\User', 1, 'auth-token', '26527a37d17b53737f62faa1bd3903176f626a9df98ae4d96508b471be0141ab', '[\"*\"]', '2026-04-30 20:47:53', NULL, '2026-04-30 20:47:21', '2026-04-30 20:47:53'),
(20, 'App\\Models\\User', 2, 'auth-token', 'f2befab82a3d751ebe2339c977cf19d14734bd37c3b2f83a9ff7f71f4e70fc40', '[\"*\"]', '2026-04-30 20:52:25', NULL, '2026-04-30 20:48:08', '2026-04-30 20:52:25'),
(21, 'App\\Models\\User', 4, 'auth-token', '70d14e451dbefa04c984267a7dcf28c486f4e9f301749e781b99bcdedb6c9465', '[\"*\"]', '2026-04-30 21:14:20', NULL, '2026-04-30 21:13:57', '2026-04-30 21:14:20'),
(22, 'App\\Models\\User', 1, 'auth-token', '9973f0e0e6a05f3a017a1261392a2cdeadd8370682a58efd51c20a7a98906f3a', '[\"*\"]', NULL, NULL, '2026-04-30 21:37:10', '2026-04-30 21:37:10'),
(23, 'App\\Models\\User', 2, 'auth-token', '5d67f014502e9fc7c245db27b274ff3a7c6bfee884d87638d0221b8eaa064e06', '[\"*\"]', '2026-04-30 21:37:32', NULL, '2026-04-30 21:37:23', '2026-04-30 21:37:32'),
(24, 'App\\Models\\User', 1, 'auth-token', 'cca319b28f39fd67f25a36bc83f5479eefe71e0a27381c02c6dfcd626d1cb79c', '[\"*\"]', '2026-05-01 00:32:03', NULL, '2026-04-30 21:37:46', '2026-05-01 00:32:03'),
(25, 'App\\Models\\User', 100, 'auth-token', '483e9c94f43d0f0f7e7a7862c978767e5397a10c535d9539e704b537a43b23ba', '[\"*\"]', '2026-05-01 00:40:33', NULL, '2026-05-01 00:32:17', '2026-05-01 00:40:33'),
(26, 'App\\Models\\User', 1, 'auth-token', 'c502095094612173407beef1da397c09cbd9a884917ba3bac29d688a039b19ec', '[\"*\"]', '2026-05-01 00:47:22', NULL, '2026-05-01 00:40:50', '2026-05-01 00:47:22'),
(27, 'App\\Models\\User', 1, 'auth-token', '56b7e1df52eb764196fdff4e7eeb8db6b1129871c25ed563f91c1e4c41ded0aa', '[\"*\"]', '2026-05-01 01:54:05', NULL, '2026-05-01 00:50:24', '2026-05-01 01:54:05'),
(28, 'App\\Models\\User', 1, 'auth-token', 'f7377cefa652ed366f867479e744d97a36d6760c3f81b355ab01b86ff6b06d74', '[\"*\"]', '2026-05-04 01:08:14', NULL, '2026-05-04 01:02:24', '2026-05-04 01:08:14');

-- --------------------------------------------------------

--
-- Table structure for table `placements`
--

CREATE TABLE `placements` (
  `id` bigint UNSIGNED NOT NULL,
  `student_id` bigint UNSIGNED NOT NULL,
  `company_id` bigint UNSIGNED NOT NULL,
  `teacher_id` bigint UNSIGNED DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` enum('active','completed','canceled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `placements`
--

INSERT INTO `placements` (`id`, `student_id`, `company_id`, `teacher_id`, `start_date`, `end_date`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(2, 11, 1, 2, '2026-01-01', '2026-06-30', 'active', 'Penempatan PKL semester genap', '2026-04-27 23:12:45', '2026-04-30 18:30:37'),
(3, 12, 2, 2, '2026-01-01', '2026-06-30', 'active', 'Penempatan PKL semester genap', '2026-04-27 23:12:45', '2026-04-30 18:30:37'),
(4, 13, 6, 2, '2026-01-01', '2026-06-30', 'active', 'Penempatan PKL semester genap', '2026-04-27 23:12:45', '2026-04-30 18:30:37'),
(5, 14, 6, 2, '2026-01-01', '2026-06-30', 'active', 'Penempatan PKL semester genap', '2026-04-27 23:12:45', '2026-04-30 18:30:37'),
(6, 15, 6, 2, '2026-01-01', '2026-06-30', 'active', 'Penempatan PKL semester genap', '2026-04-27 23:12:45', '2026-04-30 18:30:37'),
(7, 16, 6, 4, '2026-01-01', '2026-06-30', 'active', 'Penempatan PKL semester genap', '2026-04-27 23:12:45', '2026-04-30 18:30:37'),
(8, 17, 6, 2, '2026-01-01', '2026-06-30', 'active', 'Penempatan PKL semester genap', '2026-04-27 23:12:45', '2026-04-30 18:30:37'),
(9, 18, 5, 2, '2026-01-01', '2026-06-30', 'active', 'Penempatan PKL semester genap', '2026-04-27 23:12:45', '2026-04-30 18:30:37'),
(10, 19, 5, 2, '2026-01-01', '2026-06-30', 'active', 'Penempatan PKL semester genap', '2026-04-27 23:12:45', '2026-04-30 18:30:37'),
(11, 20, 3, 2, '2026-01-01', '2026-06-30', 'active', 'Penempatan PKL semester genap', '2026-04-27 23:12:45', '2026-04-30 18:30:37'),
(12, 21, 3, 2, '2026-01-01', '2026-06-30', 'active', 'Penempatan PKL semester genap', '2026-04-27 23:12:45', '2026-04-30 18:30:37'),
(13, 22, 6, 2, '2026-01-01', '2026-06-30', 'active', 'Penempatan PKL semester genap', '2026-04-27 23:12:45', '2026-04-30 18:30:37'),
(14, 23, 4, 2, '2026-01-01', '2026-06-30', 'active', 'Penempatan PKL semester genap', '2026-04-27 23:12:45', '2026-04-30 18:30:37'),
(15, 24, 5, 2, '2026-01-01', '2026-06-30', 'active', 'Penempatan PKL semester genap', '2026-04-27 23:12:45', '2026-04-30 18:30:37'),
(16, 25, 5, 2, '2026-01-01', '2026-06-30', 'active', 'Penempatan PKL semester genap', '2026-04-27 23:12:45', '2026-04-30 18:30:37'),
(18, 10, 1, 2, '2026-04-28', '2026-04-29', 'active', NULL, '2026-04-27 23:54:21', '2026-04-27 23:54:21');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_size` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `feedback` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`id`, `user_id`, `file_path`, `file_name`, `file_size`, `notes`, `status`, `feedback`, `created_at`, `updated_at`) VALUES
(1, 10, 'reports/report_10_1777421887.docx', 'Srs dan skenario use case diagram.docx', '595210', NULL, 'approved', NULL, '2026-04-28 17:18:08', '2026-04-28 17:35:58');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Admin', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(2, 'Siswa', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(3, 'Guru', '2026-04-27 23:12:40', '2026-04-27 23:12:40'),
(4, 'Perusahaan', '2026-04-27 23:12:40', '2026-04-27 23:12:40');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('1QTgTLrch6yGiAnd5CZXsupKGJfeKCbfz4zDe4SZ', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJOWEpFbkFSU29EQzlrT2F3ZTFiaXVhWmRYdUE4M3BuR2xySEZBbk12IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777881779),
('44zIIE8oEiZXEuEB4YMSf9fz5RyXF8YLx7lkDgiI', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJTTVlPRzRTajNQSThmUHRtRWlUNTVPOGhiaFNvVEJBV2xWYTVDemRFIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777882094),
('6Tdnz8IarfYmP2WU6yiN1qIvuNTNy5v49dGxv5MK', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJmMW9jZHN6M1AzWDZ6dDBNM2xJVG9jV1hOR25YbktabWh6NXNaY1VmIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2NvbXBhbmllcyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777882001),
('9Cz07hB7wJCQENZqGYajCkm97QIRtdeJ0XRpRjoz', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiIyYk9sZVpuVDFJUTlUYWRhTzNuRHBDa0JWRGRlOWpRdEYwTkNPaEVZIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2NvbXBhbmllcyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881797),
('9dsoYOEXw9BV9bunOZT62YXYnRf8Vew27lHTais2', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJoY1V0a2o0NzlVUWQyTHFzY2c4ZVZOZTRPVEdTTmVzQzdjbDQwOVJ3IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yb2xlcyIsInJvdXRlIjoicm9sZXMuaW5kZXgifSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881757),
('baBQtkJwM1pyNxxiRHkxR9dZ3NYQ8y4YWiAsYTh8', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJEeUhXNEF5ODJ3bW9iQnV4bVdUU3NiR1plSVZiY0x2NVcxYWw1MURXIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZXBvcnRzXC9ncmFkZVwvanNvbj9lbmRfZGF0ZT0yMDI2LTA1LTA0JnN0YXJ0X2RhdGU9MjAyNi0wNC0wNCIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777882012),
('BRsPpYre2rPIq704i2Y1tAyo6scYmJBVmUA2pdwm', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiIzVHZNaVhPR3A3R1owdVFVOXlRQlpnbFp0UHBzdkpwT0xuSm43ZENLIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777882064),
('cgDv7Hzh89C5cN2RnLiAhrWCUN7azzq1Z42lkOPl', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiIzeXpodUhLTnQ3S3A4SGlrMWt4MzFoN2I5RVdPWWNrNktFUzBDbkppIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9zZXR0aW5nc1wvZ2VuZXJhbCIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777882060),
('cLBZiOKmdW2ZjViefYrkHoxgYbfv3cwGavB795Y9', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJxRFg1YTE4YnhSS1dzQjA3WFlVZUlTeFAwUTBBajRKR2kxbnRmeEM4IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL21lIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777881899),
('cqc3CQvQDjd8jrZt0972K5oqoi5tDfC9jrL3Isoy', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJqR1JFa2IyUm5CTWcxbzRFQ3R1NktQMkUwNFBiQlZUeUUzN2xINVp5IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2NvbXBhbmllcyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881811),
('Ecrol5h4qRyPDsJctAh09LB77A7fpIV7x5sCmwiX', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiIyRUlOVndiYnBjcXRsRFJBVW1abkp2RDNBQ0U1eGpNdDJPSmg5TGdFIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9tb25pdG9yaW5nXC9hdHRlbmRhbmNlP2VuZF9kYXRlPTIwMjYtMDUtMDQmc3RhcnRfZGF0ZT0yMDI2LTA1LTA0Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777881796),
('eJqvDGptsXwd6JewHqa5Gvr1K0KCXAlrpVwWt4ki', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJtdXZxcDY2cWJuWmxhdlJkVmdzMVdBZDNtdk5XVVoyd1lkTENkaFRiIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC90ZWFjaGVycyIsInJvdXRlIjoidGVhY2hlcnMuaW5kZXgifSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881767),
('F2SOkVH3GNdwweqUvXoadOqrkDjZFTuKUR6Hjp5q', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJZWjhZdXVxNFJET3hLZWtGRk9qbWxqMkNZYnVHcDYyVDhseWlia3JkIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2xvZ2Jvb2tzXC8xXC9kb3dubG9hZCIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881843),
('FNmOLRNa1DuIioNcfKiejtw9Bmt49dLcI5pbi7gR', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJLY2pFS1UzYUNDanRGZHYxWGpJWUV2dlNodjA4bmJLcnI3d2FOTm01IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777881974),
('fzeVfZm2xbtQZSkxxCwgvYD7FR1QmWJW9njCokwQ', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiIzUjR3ZlFjRHhWV1BPb1BOMGh3ZUJQcWV3QUhXT1lIUEk5UFlRaTNmIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9jbGFzc2VzIiwicm91dGUiOiJjbGFzc2VzLmluZGV4In0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777881910),
('GDSXjrzUsv6mczzKslPcbAk46PDDqqOiALLyf65e', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiIxOE01dllma0s0OHdPYzlOREt1ZWRJYkxDcW9yeGtlOEd6cUhyZnBUIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2NvbXBhbmllcyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881901),
('GdtDGsq5HXlBeTSiG4V1ZtIIcrhk7S3PA4oKhCxX', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJINzVmYTIxcU1hQUdoZDhyQlZBaVpPazdlbEFJcU13T2puRWVzWVBPIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZXBvcnRzXC9ncmFkZVwvanNvbj9lbmRfZGF0ZT0yMDI2LTA1LTA0JnN0YXJ0X2RhdGU9MjAyNi0wNC0wNCIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777882015),
('GXbtZHQhhnfZGU60RKFEbPS8gf3OmfypwtwpNDrb', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJwZHNuNWFSRmFGdjB1eWwxZFNXS3VRVWtQVEtEUFFjWFpBTnQzZ1hoIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9tb25pdG9yaW5nXC9sb2dib29rXC9leHBvcnQ/Y29tcGFueV9pZD0mZW5kX2RhdGU9JnN0YXJ0X2RhdGU9JnN0YXR1cz0iLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777881830),
('H6bxMHGF9zzLM2bPooDWUtc2uTga9Y2ajSUVaFrs', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJlb2dqSVI1Qno5bzBGMWlVZzN2ejdYZGtlakZLdkJNN01JWjJnM1pnIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9tb25pdG9yaW5nXC9wcm9ncmVzcz9jbGFzc19pZD0mY29tcGFueV9pZD0iLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777881993),
('hLugtrSVCiRWrrli5pKSlORQAaer7G3c0bhqwkXK', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJKTjFYMTNxaDY5cFhWbzh3TEhCbVpDU2dVSWw1cWU3YU5vTVVIY0FmIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9kYXNoYm9hcmRcL3N0YXRzIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777882004),
('I3pKOEkN2BCXBJ1fWbFLxtZ136uC9rDLIFEAM3sT', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiIydzRudXlub1hPRWNubktRbHRJbkVPUkEzZGp4NmJveW9tWEdQWUZxIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9tb25pdG9yaW5nXC9wcm9ncmVzcz9jbGFzc19pZD0mY29tcGFueV9pZD0iLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777881909),
('i9P6Sxp8XL4ZnNxJkivBxFpvT25eqQuOUmgbGnmI', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJObGd3ZmtNSmFieXZxVTlZdkl4dVFIbU95VEZKcllyUERtRTFtSkROIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9jbGFzc2VzIiwicm91dGUiOiJjbGFzc2VzLmluZGV4In0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777882002),
('j7GP7LkGcSWPzxz4LH8Ih52zI8yzdcGyDgppb6bQ', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJEaGxDeEN5SnJZbmF1WVRiRk5Xc2IyTkF3YTBJb2JkR2kxTXNOb09JIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZXBvcnRzXC9zdW1tYXJ5XC9qc29uP2VuZF9kYXRlPTIwMjYtMDUtMDQmc3RhcnRfZGF0ZT0yMDI2LTA0LTA0Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777882013),
('kbp1SmwVIYYW7ziph4ZJshBo0pamXwrA5CdSEhdE', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJ5Q0FtTTVKY21pRW9MbWhPOEFlbEN5c0Uzc2dNTDNVVmozODBPcjdOIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777881808),
('KQ5PAllCPfHLV0ly8IwhRPnKLUlalQneS17AE1OP', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJZU1pWZGVWaFlpdlBwaUpNS2Z6WWtQYlIyVEtYSFBWSU1WNVBySnRuIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9tb25pdG9yaW5nXC9wcm9ncmVzc1wvZXhwb3J0P2NsYXNzX2lkPSZjb21wYW55X2lkPSIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881916),
('Kw4DVgqfgJJK5VtfL2UwGJGerX2KuH7KqLddMQki', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJXSktyNVo0YnZ4SjhqYkJHbzNra2tVa3hTZ3I4aG82SlU1M0JXSTN5IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9tb25pdG9yaW5nXC9sb2dib29rP2VuZF9kYXRlPSZzdGFydF9kYXRlPSZzdGF0dXM9Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777881823),
('KX2VLNQNMzZaALFFKFR6CX9X0hV2bGXlMxmuy4iQ', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiI5amRCZUttMUExR01oR0hnUVpxODBtTjhlSmM1TDh1UXlUS3dZbjdTIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777881927),
('l0uq4ZXg8rDGOfazVPeENHPZOV36QeUooHObTX0L', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJoVUtLZ05BY1htemJYUFdQZzNnNUw2VGdjcEpHOFlrV3IxdEQ0cGxDIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9jbGFzc2VzIiwicm91dGUiOiJjbGFzc2VzLmluZGV4In0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777881784),
('lRdgrikh2EWsRqgQyuR4FLKetAEstVN0qRGohHha', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJqZTdpbUJIc0hZMUxEQWpkS3dSZXhFTUFkMjBLS3dNNnpjaExNU0VoIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC90b3Atc3R1ZGVudHMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777881753),
('LSEoBTIcbEiDy5Ef4hJqxqLm15txXfWn4UQ9QT1T', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJ3bjVoN1ZncHN3b0VJUnM3NURsOU40SVBwcGFzbzNOendQUWpFMUtDIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9jbGFzc2VzIiwicm91dGUiOiJjbGFzc2VzLmluZGV4In0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777881948),
('lSPaCghbmaQnkRmpF1ltd9zrKwNbhKATrkGY1BkI', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJIbVFyaUpKemEyUVRLVzZCcmFyVVpwSnppWTU1Y1dZd1Y4dFhESFR0IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2NvbXBhbmllcyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777882049),
('LXYBkQIL7VgxKXVgSN7jTo2lUxGoikWfWj2aLLCV', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJyNGJ4Q2RCdWdFb3p6SnluWjJsdFE5OGJlUmZ6MEJQWG92UGpUd0J2IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777882012),
('lzKHDLVmurOkk1v4BOLhhPnRXHaZXWO442SIt3yc', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJyWXhVc2lVTjRvQktjaTF4ZkxQTHJzRXZ2cGhhckR5SHFvUVNEdE5MIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZXBvcnRzXC9sb2dib29rXC9qc29uP2VuZF9kYXRlPTIwMjYtMDUtMDQmc3RhcnRfZGF0ZT0yMDI2LTA0LTA0Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777882028),
('m1E4tIcoQrFxprE0PDHN9BfahbP3h2eHJPi2SwDx', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiI3aEFMZm44bUpnNlJrRzRFYmJtam5PZTF0ODZMY2wwbWp6VjJDSmVpIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9zdHVkZW50c1wvYXNzZXNzbWVudHMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777882047),
('oanjqmpEowLU2BUULsjg36UZnLMDEqictdGOgSob', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJPRlJlRmhLQVlYZ2JVanlSNXNJRWw2SGxudHF2VXJHbFVyNTR6dlhGIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZXBvcnRzXC9hdHRlbmRhbmNlXC9qc29uP2VuZF9kYXRlPTIwMjYtMDUtMDQmc3RhcnRfZGF0ZT0yMDI2LTA0LTA0Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777882035),
('opU9mLYnqjcyrHrgSO1y39JCObWq37EHRa1rXbo2', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJjYVZZZzk3VjY0SndwUk91Q0hqRE9lS3E1R1hSak1DVHhuaHlrTWpKIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9zZXR0aW5nc1wvbm90aWZpY2F0aW9ucyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777882061),
('orF6pgWWUtCcMG9RFbnchARaU7OggWBb0bjOyCz4', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJ6QVZIUmJGVUNMak5EdVd1cUF1VGQ0QTZVREliVHRUcDZ6NW5UTVQ5IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZXBvcnRzXC9sb2dib29rXC9qc29uP2VuZF9kYXRlPTIwMjYtMDUtMDQmc3RhcnRfZGF0ZT0yMDI2LTA0LTA0Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777882027),
('oRR1KVM7m4xSco9LgpckJRwxE4BASY3Ja4GY3dPN', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJVMnhEMlN6VG9kaFdtU0drT3ZacmQybjYxN0ZhVnF0V214YUFxMXowIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9tb25pdG9yaW5nXC9hdHRlbmRhbmNlP2VuZF9kYXRlPTIwMjYtMDUtMDQmc3RhcnRfZGF0ZT0yMDI2LTA0LTA0Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777881810),
('Pa79AWnmmsjUK4H5flTBY8uc1vet6N3yOj8ceeSK', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJ6QWdIRVJjR1AyNnBRN3dTUTE0NFZFemFOd2lIYWplMmxkcFhBdkp6IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9zZXR0aW5nc1wvcnVsZXMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777882060),
('PaiNr5TcJk0hi1hweBmwyFQD56WlEZJiw3WoiuUT', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJRWlhWZlB4cWJISmdKdGxvMWdteTI0MG1ETEt3Mm9lTmpxZW1FamlBIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2NvbXBhbmllcyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881823),
('phOyLxti7xujoMAGwb1l48yzq4bNoaKXbJJS4kwA', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJld2UzdjNFSlVkWXJwWTBhUmJFSVlNczhzYzZrV2g4cmtxdmFPSXY0IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9kYXNoYm9hcmRcL3N0YXRzIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777881750),
('qbv4Re3wZAZr8hZpv2VdO8bL3rNpJ6AGizDsl1xb', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJGaUhoTmh0M2Zna24yalpSQ09xaWtqUnFDQVZmWEwySlRydmZlSFJCIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9zdHVkZW50cyIsInJvdXRlIjoic3R1ZGVudHMuaW5kZXgifSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881765),
('Qgx9izXoo65zES00xQpAMK9YtciTUOEaeu96bpr6', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJZNXZzclVvUzU3Rno1TWJqdWFVb1A1dGdrYXFyVkFJaWd6VE5NWWFnIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL21lIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777881946),
('Qorbq4LPEfgEbvTU0YC2xiB7MYwuqemuWosb3BUv', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJpdjVCNUZRY0ZYdnF3aEFKQk1pTjRyeWNMMmVaYmlNMG44RkllTEVTIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9zdHVkZW50cyIsInJvdXRlIjoic3R1ZGVudHMuaW5kZXgifSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777882004),
('rI1osra2JDK3NFkqpCFvuAjFCTBTc5an6XYVAB95', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJPc2F6WUd6dDg0RDRNRWF2Qk82Q0k4M0NGUWZxeVpwOEdKZ3Z0cEE3IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9tb25pdG9yaW5nXC9wcm9ncmVzc1wvZXhwb3J0P2NsYXNzX2lkPSZjb21wYW55X2lkPSIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881915),
('rnaJnPdSXx9YGmIXvzyrXXo3YDyTZpNPgTlTjKL7', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJ0Qzdtd3NUZ1E1RGhvanR6dm5rUG5rT1FUdjBKeEUzV2ltZ1FXVnlpIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777882036),
('rNXvPNhCNlQyiBO0nJ2edJuYUwsn5UJ4ulxcOj47', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJ4dDA0dlNreHdYbUtqNWpOdmRHZERTRVRmNTlaYTR3eDlDTXBncXlIIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777881840),
('rSBS1HpxyuDBNxSyDvtrZzBMdpLRwyYPiIhKPFSl', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJRbHlES2NaWm10SUVuTVI2NGx6TFQ0S2VJUGpaaWc5alJid0thQVFGIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2NvbXBhbmllcyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881911),
('S0ZX77sH109yVRbCCA2rGGPPt3qwlEy7S5JGFekk', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJwNFBWblRKOVl4Rzh3R3FxMDZGZDVZYWtnc2RXMEY0MkNHQnhZSGRlIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZXBvcnRzXC9ncmFkZVwvanNvbj9lbmRfZGF0ZT0yMDI2LTA1LTA0JnN0YXJ0X2RhdGU9MjAyNi0wNC0wNCIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777882017),
('SnVscFxmOGUSEQKJ4H6qdLDuaEqVIC9WZXju2IIW', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJtSGgzbjVjSDRsNmMzanZZYWdXNFRkcXR4c29kb0RUMG5LMFg3OFNSIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZXBvcnRzXC9sb2dib29rXC9qc29uP2VuZF9kYXRlPTIwMjYtMDUtMDQmc3RhcnRfZGF0ZT0yMDI2LTA0LTA0Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777882011),
('szHzRoewvZdGBOl7yeZHfxLL84mzK6GUR8ogwFg4', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiI0WnFlT1NjRmIzY2txU0tsY2dRbXFNQ3JPMGhWMmhIVkFWZGNUQTlrIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2xvZ2Jvb2tzXC8xXC9kb3dubG9hZCIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881837),
('t8yMrDAn3MPqrIEzOdUh9Ykg5qifeXB0gtnNzBrL', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJFWmNtQ0NhTldYNkROTHdzcHVoU29wMmtsb3kwY3lRZUVYakJIRzliIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZXBvcnRzXC9ncmFkZVwvanNvbj9lbmRfZGF0ZT0yMDI2LTA1LTA0JnN0YXJ0X2RhdGU9MjAyNi0wNC0wNCIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777882018),
('Tllpt5VHqRgj4ASKQosIK3i8si4PN9KgDxExvOmR', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJBWjExQkFVVUNZbWRTck5QVURDSEFsWGl2dkVVWDZpSHVIUjJPa2EzIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZXBvcnRzXC9hdHRlbmRhbmNlXC9qc29uP2VuZF9kYXRlPTIwMjYtMDUtMDQmc3RhcnRfZGF0ZT0yMDI2LTA0LTA0Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777882037),
('TqdOvsoHL1lq2o8dbysaHTZBxZpM7qF31GrG63SA', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJtQWhVRDk5RlVkNE95MXB2RmRTRnhHdzdxck82Zml1SWg1bHVlYkxHIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC90ZWFjaGVycyIsInJvdXRlIjoidGVhY2hlcnMuaW5kZXgifSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881785),
('Ts1U0RnCJ28SO5RkxOtEzWv0HRmUnrx2yesnFeuZ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJ1UnlFTFJnWlZMMllFUWJTUXNWRGlWRnRPUVJ0T1NRMVF4akxOTVhVIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777882107),
('u7MW7nL1miapONZGlZHlK1GpVC1o6UjnicRcerZo', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJwY05zZDRJWVdTSDJxdXVqZHRkeW5mb1ZzSGZZdEl6U0hwRDk5eHRNIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZXBvcnRzXC9ncmFkZVwvanNvbj9lbmRfZGF0ZT0yMDI2LTA1LTA0JnN0YXJ0X2RhdGU9MjAyNi0wNC0wNCIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777882009),
('uNjBcstYBr3RNVfyBAqTT8za3XMu0WarpSpWX1qc', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJoZVlzWWlMVmVldElndWI0bDg4cFk0SHZSNVIyclRmcWVsZUVaaDZlIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2NvbXBhbmllcyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881766),
('UWeouc32YjyFGW8SeeFrKccp9TrRmZgyoXx3Mw7f', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJlRG8wYWI0UGtLUVZHRFB3Q2VvcmFQNUtwYWNrYUFSOEllSFRIVDVWIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881746),
('v2RQ9Ij6fd0xeeVsijYyu3767CnK9m9IWiWboiTY', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJXNHFRc3JCc2tSM2Vrb1dEREFoQ2h4ZWhIcmFOSGJaZlhvTWxLSXl0IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9tb25pdG9yaW5nXC9sb2dib29rXC9leHBvcnQ/Y29tcGFueV9pZD0mZW5kX2RhdGU9JnN0YXJ0X2RhdGU9JnN0YXR1cz0iLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777881828),
('vodkIO3vIhM4CJWqexV2zsyqf02qm7TzfUfu0dCG', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJQbmN1NVVSWTZMTVJ1NW43TjQzeEFKb0hBaGZRS1hWOU1MNGFrbW0xIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9hdHRlbmRhbmNlXC9zdGF0cyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881751),
('vq3y3HIJ4DZp6vrpKTUMZW4eO4zgPtI6nk8ZtKAp', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJHT3UyTHZOZUVqYURJRGVKOXNCakVLR3gwaEk3d2dUeU14eHRzb08yIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZXBvcnRzXC9sb2dib29rXC9qc29uP2VuZF9kYXRlPTIwMjYtMDUtMDQmc3RhcnRfZGF0ZT0yMDI2LTA0LTA0Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777882007),
('vVtBNGPjRwe1SCYGjp5YD1AOfGSkMI8sRhVuDSn4', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJnNmo3cmR0UHRkRlpSM3FOOTVtUURVUEVFSHJRNjZXcGlrZkVRRnFFIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2xvZ2Jvb2tzXC8xXC9kb3dubG9hZCIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881841),
('WAaeeRMALdnhKkILtfYkJkzCUeCRWQFqCtigsKBY', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJ1SG1QQ241NVQ2VTdCbXRTTVhMbGZsWkRsd2NpZk1YakxnbmRyaEc2IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC91c2Vycz9wYWdlPTEiLCJyb3V0ZSI6InVzZXJzLmluZGV4In0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777881754),
('wg4olyLLnP8psZg6elsZk46zfGvXkGKL7XJkLgqh', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJ1TFluVFhWRHM3MVRXYklPamJXU1hBVjB3TGFqUWpZbU91VW9KWUppIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZWNlbnQtYWN0aXZpdGllcyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881752),
('Wzlgs9OzBBbImsrsUfmunqqjTTAod5BupBtZYrUa', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJvR2FvWVdvSVFzVkdzZFI4STRubDhXWTdkdjRVd1JKTUxVNlJYRmtYIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777881868),
('X66u5TQNUkduFYxW8wPoJx3rvWakc7KvhYIC7RzI', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJ0d29Caml5TEVWV255OG9IM2Npb0pQQWRnY0JtaFRyanJZYjhKWXhVIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9tb25pdG9yaW5nXC9wcm9ncmVzcz9jbGFzc19pZD0mY29tcGFueV9pZD0iLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777881947),
('xd2dEZKFNKRyKlAlNMTrrlg5VlhKMPiN06emdrQW', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJ4V3YxNnNKbzBtaWdkcmJVT1RaWUo0azJoZ0NPWFFNd0I4V3pUdFhaIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9jb21wYW5pZXMiLCJyb3V0ZSI6ImNvbXBhbmllcy5pbmRleCJ9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777881780),
('xIJcnblJoJ2jLBI1DmJYO0e73Z8LI6yH1Ynxn8rP', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiIwYXZHQnFPTjNSVzQyRE1VQm5tQjhxQml0b3F3VlNSSUNNVW10Q3JEIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2NvbXBhbmllcyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881949),
('Xoig8E8xsUigmIqiKzpGq3l1IYQUq1veknSJQxdl', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJrRk1PWjNjQXdoTkxucjdQemE0dGJubWZDVHdUV013UjVNZUVCNE1lIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC90ZWFjaGVycyIsInJvdXRlIjoidGVhY2hlcnMuaW5kZXgifSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777882048),
('xowhjqmCFnyB81QP5mSIMnz6W1AiaYNoq1FiI9t1', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJ3dGQzZ0wwVnBqOHhnTTdUNm9UTjhxcURGbjI2MG5OUXRGWHN0MEQ0IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC90ZWFjaGVycyIsInJvdXRlIjoidGVhY2hlcnMuaW5kZXgifSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1777881772),
('YBcBa3xikavP83p9fREOimZLn2OnioRbrw6llQMt', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJzc3BUQXd2MTV6Tk1oem5uVVZnTGpOb1VCaU52QkZXRlU2RVdHeW5xIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZXBvcnRzXC9zdW1tYXJ5XC9qc29uP2VuZF9kYXRlPTIwMjYtMDUtMDQmc3RhcnRfZGF0ZT0yMDI2LTA0LTA0Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777882016),
('ZoIqScVAKzrEW2101GLLfYe6o86AVIqiRATIzH7U', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiI4YVdoTXoxU2xGVDRkanNkQlJUYlBCYkp1bTdNekJwWXVTaDNwN1hyIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9tb25pdG9yaW5nXC9sb2dib29rP2VuZF9kYXRlPSZzdGFydF9kYXRlPSZzdGF0dXM9Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777881900);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nisn` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kelas` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jurusan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mata_pelajaran` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bidang_usaha` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kontak_person` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_id` bigint UNSIGNED NOT NULL,
  `company_id` bigint UNSIGNED DEFAULT NULL,
  `teacher_id` bigint UNSIGNED DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `registration_status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `rejection_reason` text COLLATE utf8mb4_unicode_ci,
  `approved_by` bigint UNSIGNED DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `class_id` bigint UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `nisn`, `kelas`, `jurusan`, `nip`, `mata_pelajaran`, `phone`, `bidang_usaha`, `kontak_person`, `role_id`, `company_id`, `teacher_id`, `remember_token`, `created_at`, `updated_at`, `registration_status`, `rejection_reason`, `approved_by`, `approved_at`, `is_active`, `class_id`) VALUES
(1, 'Administrator', 'admin@smkn1subang.sch.id', '$2y$12$qeMrQm4Pj58au4IHujfvQ.O8m3pTZ/iHfPAKas8xpLR7t0tj.RQay', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, '2026-04-27 23:12:45', '2026-04-27 23:12:45', 'pending', NULL, NULL, NULL, 1, NULL),
(2, 'Budi Santoso, S.Pd', 'budi.santoso@smkn1subang.sch.id', '$2y$12$NKBX7NkqlfvOvbpnZobcHeSL5d1v.QWPC.GHj3UJvTUyxgv2iwQ9m', NULL, NULL, NULL, '197501012005011001', 'Teknik Pemesinan', '081234567891', NULL, NULL, 3, NULL, NULL, NULL, '2026-04-27 23:12:40', '2026-04-27 23:12:40', 'pending', NULL, NULL, NULL, 1, NULL),
(3, 'Siti Rahayu, S.Kom', 'siti.rahayu@smkn1subang.sch.id', '$2y$12$UGwVKXybUpO7jwMrofEoFOLB5fW9qW9X3khrg5P1D8G0kcsUmEoSK', NULL, NULL, NULL, '197803152006012002', 'Rekayasa Perangkat Lunak', '081234567892', NULL, NULL, 3, NULL, NULL, NULL, '2026-04-27 23:12:40', '2026-04-27 23:12:40', 'pending', NULL, NULL, NULL, 1, NULL),
(4, 'Ahmad Hidayat, S.T', 'ahmad.hidayat@smkn1subang.sch.id', '$2y$12$OaLwPJC/SUFmBqSF3DJJ/.9eVEdQT/hKIMd3xjTO9I9zJT0w2JGt.', NULL, NULL, NULL, '198005202007011003', 'Teknik Komputer dan Jaringan', '081234567893', NULL, NULL, 3, NULL, NULL, NULL, '2026-04-27 23:12:40', '2026-04-27 23:12:40', 'pending', NULL, NULL, NULL, 1, NULL),
(5, 'Dewi Kartika, S.E', 'dewi.kartika@smkn1subang.sch.id', '$2y$12$bxVoERZ3IULcFuspsDbEYOCb3eLGa/3w8sICuOliTuRfvfOBgFCmS', NULL, NULL, NULL, '198307222008012004', 'Akuntansi', '081234567894', NULL, NULL, 3, NULL, NULL, NULL, '2026-04-27 23:12:41', '2026-04-27 23:12:41', 'pending', NULL, NULL, NULL, 1, NULL),
(6, 'Rina Susanti, S.Pd', 'rina.susanti@smkn1subang.sch.id', '$2y$12$NmcXJs2is/oWUmuPFRufXOanRpZUAG3esb7BBzNYRMWva64.IFt4a', NULL, NULL, NULL, '198410102009012005', 'Tata Boga', '081234567895', NULL, NULL, 3, NULL, NULL, NULL, '2026-04-27 23:12:41', '2026-04-27 23:12:41', 'pending', NULL, NULL, NULL, 1, NULL),
(10, 'Ahmad Fauzi', 'ahmadfauzi@student.smkn1subang.sch.id', '$2y$12$dNALHNaPkja422B5UOY4Zen9vCYJ1T8TRsqEG/9/wMYC.mEtL3Pda', '0012345601', NULL, NULL, NULL, NULL, '081296387948', NULL, NULL, 2, 1, 2, NULL, '2026-04-27 23:12:41', '2026-04-28 21:38:57', 'pending', NULL, NULL, NULL, 1, 1),
(11, 'Rizki Ramadhan', 'rizkiramadhan@student.smkn1subang.sch.id', '$2y$12$1/LJWkI50lQdNDQIYMvSguQjRSpvzy48bMNL5CNlncOzIHdBaz62W', '0012345602', NULL, NULL, NULL, NULL, '081227608861', NULL, NULL, 2, 1, 2, NULL, '2026-04-27 23:12:41', '2026-04-28 21:38:57', 'pending', NULL, NULL, NULL, 1, 1),
(12, 'Bagas Saputra', 'bagassaputra@student.smkn1subang.sch.id', '$2y$12$1paamLFzfRxU9AChYxquZ.0SFowO6ZbPWyeW2WueLsz9AGGBNCHm2', '0012345603', NULL, NULL, NULL, NULL, '081228513676', NULL, NULL, 2, 2, 2, NULL, '2026-04-27 23:12:41', '2026-04-28 21:38:57', 'pending', NULL, NULL, NULL, 1, 1),
(13, 'Siti Nurhaliza', 'sitinurhaliza@student.smkn1subang.sch.id', '$2y$12$zrX/XnuOcHOzgMOWnuPW4eDWpQOVVmF2Yx13sglXtEZA6KsAgvghi', '0012345610', NULL, NULL, NULL, NULL, '081246411472', NULL, NULL, 2, 6, 2, NULL, '2026-04-27 23:12:42', '2026-04-28 21:38:57', 'pending', NULL, NULL, NULL, 1, 7),
(14, 'Dewi Anggraeni', 'dewianggraeni@student.smkn1subang.sch.id', '$2y$12$KN1spXjH1Np6Tt0CzWQqWOd1AXy9.p/e/.vofIUQMWHehBn5IrGz6', '0012345611', NULL, NULL, NULL, NULL, '081275676777', NULL, NULL, 2, 6, 2, NULL, '2026-04-27 23:12:42', '2026-04-28 21:38:57', 'pending', NULL, NULL, NULL, 1, 7),
(15, 'Muhammad Irfan', 'muhammadirfan@student.smkn1subang.sch.id', '$2y$12$ZNwvJT9RaC/LwmqZX60dyOcLxc1KnoDc5QTxdbwSNcI1J8mczxdIK', '0012345612', NULL, NULL, NULL, NULL, '081233036938', NULL, NULL, 2, 6, 2, NULL, '2026-04-27 23:12:42', '2026-04-28 21:38:57', 'pending', NULL, NULL, NULL, 1, 7),
(16, 'Andi Wijaya', 'andiwijaya@student.smkn1subang.sch.id', '$2y$12$V78P1NFjHmG1hDWDNj2PPO/A7CwWnetjfIDvPu8Qxgqopb2J6VSTi', '0012345620', NULL, NULL, NULL, NULL, '081297189564', NULL, NULL, 2, 6, 4, NULL, '2026-04-27 23:12:42', '2026-04-30 18:25:22', 'pending', NULL, NULL, NULL, 1, 10),
(17, 'Budi Prasetyo', 'budiprasetyo@student.smkn1subang.sch.id', '$2y$12$fflVtIFqcfsCRitAfk8yEOaNylDy2YCtJln3U8xkbI1XgKCqSdjaW', '0012345621', NULL, NULL, NULL, NULL, '081255167759', NULL, NULL, 2, 6, 2, NULL, '2026-04-27 23:12:42', '2026-04-28 21:38:57', 'pending', NULL, NULL, NULL, 1, 10),
(18, 'Linda Febriyanti', 'lindafebriyanti@student.smkn1subang.sch.id', '$2y$12$Ysh/EcLYmEblGDiSAs/1ueVxF77/Kavres3i/5hnxiFZPmAK7sz.2', '0012345630', NULL, NULL, NULL, NULL, '081299631404', NULL, NULL, 2, 5, 2, NULL, '2026-04-27 23:12:43', '2026-04-28 21:38:57', 'pending', NULL, NULL, NULL, 1, 19),
(19, 'Nadia Putri', 'nadiaputri@student.smkn1subang.sch.id', '$2y$12$ilQsN4wpQFKDYIoHB7ORyuGcJIaVsMZAi33Qw67qx//4H5yLwIlVi', '0012345631', NULL, NULL, NULL, NULL, '081211477803', NULL, NULL, 2, 5, 2, NULL, '2026-04-27 23:12:43', '2026-04-28 21:38:57', 'pending', NULL, NULL, NULL, 1, 19),
(20, 'Putri Amelia', 'putriamelia@student.smkn1subang.sch.id', '$2y$12$arsd9jfLWjZBQ/C3aocC6uAbdRU.S0rwpOxe8kQtfSMv7se8mkYfe', '0012345640', NULL, NULL, NULL, NULL, '081294339249', NULL, NULL, 2, 3, 2, NULL, '2026-04-27 23:12:43', '2026-04-28 21:38:57', 'pending', NULL, NULL, NULL, 1, 21),
(21, 'Rina Febriani', 'rinafebriani@student.smkn1subang.sch.id', '$2y$12$80WMrU3DHBe57cgV0dHbgu/Y6D1XAdqOBpQfY0z.kTp1rCee60qL.', '0012345641', NULL, NULL, NULL, NULL, '081290825412', NULL, NULL, 2, 3, 2, NULL, '2026-04-27 23:12:43', '2026-04-28 21:38:57', 'pending', NULL, NULL, NULL, 1, 21),
(22, 'Eka Prasetya', 'ekaprasetya@student.smkn1subang.sch.id', '$2y$12$W3zrQ2/5UsO0aM9ijzaFqu/WtYmq/mmwRUYIYp6yp80rmHPahuH9y', '0012345650', NULL, NULL, NULL, NULL, '081221232744', NULL, NULL, 2, 6, 2, NULL, '2026-04-27 23:12:43', '2026-04-28 21:38:57', 'pending', NULL, NULL, NULL, 1, 4),
(23, 'Fajar Nugroho', 'fajarnugroho@student.smkn1subang.sch.id', '$2y$12$uy/WqbvmPqRv7GScn.3IO.3V4OOxRmPe7yu0NSYJKBNKBKt4S.PYC', '0012345660', NULL, NULL, NULL, NULL, '081242802584', NULL, NULL, 2, 4, 2, NULL, '2026-04-27 23:12:44', '2026-04-28 21:38:57', 'pending', NULL, NULL, NULL, 1, 6),
(24, 'Gina Lestari', 'ginalestari@student.smkn1subang.sch.id', '$2y$12$eXWawFPNRA6Kd8YHHxKVJ.Mcys5OxDa3mBioCJofQXFYlz.eL1LSW', '0012345670', NULL, NULL, NULL, NULL, '081289513212', NULL, NULL, 2, 5, 2, NULL, '2026-04-27 23:12:44', '2026-04-28 21:38:57', 'pending', NULL, NULL, NULL, 1, 13),
(25, 'Hendra Gunawan', 'hendragunawan@student.smkn1subang.sch.id', '$2y$12$wFDBL7JywRLPZ9SY7ZUJLuUVuDjl8cv4Y3aWEZdLA9TqcDYu2vH0C', '0012345680', NULL, NULL, NULL, NULL, '081295873692', NULL, NULL, 2, 5, 2, NULL, '2026-04-27 23:12:44', '2026-04-28 21:38:57', 'pending', NULL, NULL, NULL, 1, 16),
(100, 'PT. Honda Prospect Motor', 'honda@perusahaan.com', '$2y$12$P5RIaiuwz.n8DI21hXxt1On9bh1MHch5IK3EdsaYtaNW2TWo7.VWK', NULL, NULL, NULL, NULL, NULL, '081234567800', NULL, NULL, 4, 1, NULL, NULL, '2026-04-27 23:12:44', '2026-04-27 23:12:44', 'pending', NULL, NULL, NULL, 1, NULL),
(101, 'PT. Toyota Manufacturing', 'toyota@perusahaan.com', '$2y$12$JgihftJYQNhrBnbD6sDv4.t64.e1i0sf4HAmVlqHDxSi1VtjRWnd.', NULL, NULL, NULL, NULL, NULL, '081234567801', NULL, NULL, 4, 2, NULL, NULL, '2026-04-27 23:12:44', '2026-04-27 23:12:44', 'pending', NULL, NULL, NULL, 1, NULL),
(102, 'PT. Unilever Indonesia', 'unilever@perusahaan.com', '$2y$12$/UIRv3hW5DIRifYYTQ2qzebwfGEquSCzA//4zESGu/yE5NAywMxym', NULL, NULL, NULL, NULL, NULL, '081234567802', NULL, NULL, 4, 3, NULL, NULL, '2026-04-27 23:12:44', '2026-04-27 23:12:44', 'pending', NULL, NULL, NULL, 1, NULL),
(103, 'PT. Pertamina', 'pertamina@perusahaan.com', '$2y$12$DOiGEXsnzVZjr6KZY3g7o.2PIMwBh6RvPc35qYJ2DCwC3s7G4YUkS', NULL, NULL, NULL, NULL, NULL, '081234567803', NULL, NULL, 4, 4, NULL, NULL, '2026-04-27 23:12:45', '2026-04-27 23:12:45', 'pending', NULL, NULL, NULL, 1, NULL),
(104, 'PT. Bank Mandiri', 'mandiri@perusahaan.com', '$2y$12$CJdGpedBH1OyuzbUFhRy/evca20LJrNV0dAylckfMy60.PKlK9Jse', NULL, NULL, NULL, NULL, NULL, '081234567804', NULL, NULL, 4, 5, NULL, NULL, '2026-04-27 23:12:45', '2026-04-27 23:12:45', 'pending', NULL, NULL, NULL, 1, NULL),
(105, 'PT. Gojek Indonesia', 'gojek@perusahaan.com', '$2y$12$iB7qWxEdMcdiPUv57PiBaOfl0SsUUzAh/mhz8y8ixY3oawmyd2cyS', NULL, NULL, NULL, NULL, NULL, '081234567805', NULL, NULL, 4, 6, NULL, NULL, '2026-04-27 23:12:45', '2026-04-27 23:12:45', 'pending', NULL, NULL, NULL, 1, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assessments`
--
ALTER TABLE `assessments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assessments_assessor_id_foreign` (`assessor_id`),
  ADD KEY `assessments_student_id_assessor_type_index` (`student_id`,`assessor_type`);

--
-- Indexes for table `attendances`
--
ALTER TABLE `attendances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attendances_user_id_foreign` (`user_id`),
  ADD KEY `attendances_company_id_foreign` (`company_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `classes_teacher_id_foreign` (`teacher_id`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `final_reports`
--
ALTER TABLE `final_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `final_reports_student_id_foreign` (`student_id`),
  ADD KEY `final_reports_reviewer_id_foreign` (`reviewer_id`);

--
-- Indexes for table `logbooks`
--
ALTER TABLE `logbooks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `logbooks_user_id_foreign` (`user_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_user_id_foreign` (`user_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permissions_user_id_foreign` (`user_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `placements`
--
ALTER TABLE `placements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `placements_student_id_foreign` (`student_id`),
  ADD KEY `placements_company_id_foreign` (`company_id`),
  ADD KEY `placements_teacher_id_foreign` (`teacher_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reports_user_id_foreign` (`user_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_nisn_unique` (`nisn`),
  ADD KEY `users_role_id_foreign` (`role_id`),
  ADD KEY `users_company_id_foreign` (`company_id`),
  ADD KEY `users_teacher_id_foreign` (`teacher_id`),
  ADD KEY `users_approved_by_foreign` (`approved_by`),
  ADD KEY `users_nip_index` (`nip`),
  ADD KEY `users_nisn_index` (`nisn`),
  ADD KEY `users_class_id_foreign` (`class_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assessments`
--
ALTER TABLE `assessments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `attendances`
--
ALTER TABLE `attendances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `final_reports`
--
ALTER TABLE `final_reports`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logbooks`
--
ALTER TABLE `logbooks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `placements`
--
ALTER TABLE `placements`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assessments`
--
ALTER TABLE `assessments`
  ADD CONSTRAINT `assessments_assessor_id_foreign` FOREIGN KEY (`assessor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `assessments_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `attendances`
--
ALTER TABLE `attendances`
  ADD CONSTRAINT `attendances_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  ADD CONSTRAINT `attendances_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `classes`
--
ALTER TABLE `classes`
  ADD CONSTRAINT `classes_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `final_reports`
--
ALTER TABLE `final_reports`
  ADD CONSTRAINT `final_reports_reviewer_id_foreign` FOREIGN KEY (`reviewer_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `final_reports_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `logbooks`
--
ALTER TABLE `logbooks`
  ADD CONSTRAINT `logbooks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `permissions`
--
ALTER TABLE `permissions`
  ADD CONSTRAINT `permissions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `placements`
--
ALTER TABLE `placements`
  ADD CONSTRAINT `placements_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  ADD CONSTRAINT `placements_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `placements_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `users_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `users_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
