-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 08, 2026 at 07:38 AM
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
(17, 25, 5, '2026-04-29', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-04-29 20:30:25', '2026-04-29 20:30:25'),
(18, 10, 1, '2026-04-28', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-05-04 01:53:35', '2026-05-04 01:53:35'),
(19, 10, 1, '2026-05-01', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-05-04 01:53:35', '2026-05-04 01:53:35'),
(20, 10, 1, '2026-05-04', '08:53:35', '08:54:00', -6.57832900, 107.78356200, -6.57832900, 107.78356200, 'late', NULL, NULL, 1, '2026-05-04 01:53:35', '2026-05-04 01:54:00'),
(21, 10, 1, '2026-05-05', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-05-07 03:00:13', '2026-05-07 03:00:13'),
(22, 10, 1, '2026-05-06', NULL, NULL, NULL, NULL, NULL, NULL, 'absent', 'Tidak hadir tanpa keterangan', NULL, 0, '2026-05-07 03:00:13', '2026-05-07 03:00:13'),
(23, 10, 1, '2026-05-07', '10:00:13', NULL, -6.57836467, 107.78339400, NULL, NULL, 'late', NULL, NULL, 1, '2026-05-07 03:00:13', '2026-05-07 03:00:13');

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
(27, 'App\\Models\\User', 1, 'auth-token', '56b7e1df52eb764196fdff4e7eeb8db6b1129871c25ed563f91c1e4c41ded0aa', '[\"*\"]', '2026-05-07 02:58:39', NULL, '2026-05-01 00:50:24', '2026-05-07 02:58:39'),
(28, 'App\\Models\\User', 1, 'auth-token', 'f7377cefa652ed366f867479e744d97a36d6760c3f81b355ab01b86ff6b06d74', '[\"*\"]', '2026-05-04 01:08:14', NULL, '2026-05-04 01:02:24', '2026-05-04 01:08:14'),
(29, 'App\\Models\\User', 4, 'auth-token', 'f9b3400680359174a7bf74bcf7ed7ab0198a2971306a78b099c2e6dcb235d08d', '[\"*\"]', '2026-05-04 01:49:35', NULL, '2026-05-04 01:49:18', '2026-05-04 01:49:35'),
(30, 'App\\Models\\User', 1, 'auth-token', '43b31024f65fa2b99963580a30f31b0bd2fa12a2280c60193044fe3a84f18361', '[\"*\"]', '2026-05-04 01:51:55', NULL, '2026-05-04 01:49:54', '2026-05-04 01:51:55'),
(31, 'App\\Models\\User', 10, 'auth-token', '36a0a197169f4c8967657859cc7a20445c92681d8b59d46921aa67c7c0a4e309', '[\"*\"]', '2026-05-04 01:54:38', NULL, '2026-05-04 01:52:03', '2026-05-04 01:54:38'),
(32, 'App\\Models\\User', 1, 'auth-token', 'a7f9dbe36b692714a5593467783e3d737f2555dd80ba22880f77dc5d16269432', '[\"*\"]', '2026-05-04 01:59:20', NULL, '2026-05-04 01:56:05', '2026-05-04 01:59:20'),
(33, 'App\\Models\\User', 1, 'auth-token', 'b46d2dabfa54c3ce02c4941e532b7bb8876f9a2e7f9fc934b582bd33724d3ec1', '[\"*\"]', NULL, NULL, '2026-05-04 05:20:01', '2026-05-04 05:20:01'),
(34, 'App\\Models\\User', 1, 'auth-token', 'd0e88cdbfdccc55161d1eeae00072eb11e757a1d7ee6dff65194dd6eeec28988', '[\"*\"]', NULL, NULL, '2026-05-04 05:21:16', '2026-05-04 05:21:16'),
(35, 'App\\Models\\User', 1, 'auth-token', '158083bfd2aa76aae2f29908476bb0c6aa8b4704fcb0f5e76fbaccca15091860', '[\"*\"]', NULL, NULL, '2026-05-04 05:21:36', '2026-05-04 05:21:36'),
(36, 'App\\Models\\User', 1, 'auth-token', '37d6324817a1ece0757dd5028e8a477aa6a1c720e99c6f89792855486893473f', '[\"*\"]', NULL, NULL, '2026-05-04 05:23:15', '2026-05-04 05:23:15'),
(37, 'App\\Models\\User', 1, 'auth-token', 'a0d79e8afe7998ebaf90220fb596f1f54a29a23ccdc846bb656de29c8c7a9900', '[\"*\"]', NULL, NULL, '2026-05-04 05:23:30', '2026-05-04 05:23:30'),
(38, 'App\\Models\\User', 1, 'auth-token', 'f3c55209ac4830a281eab04880da018d95a39bade9ab19d0ab37488ba3eee4f1', '[\"*\"]', NULL, NULL, '2026-05-04 05:23:34', '2026-05-04 05:23:34'),
(39, 'App\\Models\\User', 1, 'auth-token', 'a836c52f3823c866aff98cff792f8f36c7a8d999c1ebc01a4cf67da426dfcaaf', '[\"*\"]', NULL, NULL, '2026-05-04 05:23:41', '2026-05-04 05:23:41'),
(40, 'App\\Models\\User', 1, 'auth-token', '07a8337b14bfb4b7eed9b1ddf48de7daec7683cae53f26e0bc32f28a3e9fcd30', '[\"*\"]', NULL, NULL, '2026-05-04 05:30:07', '2026-05-04 05:30:07'),
(41, 'App\\Models\\User', 1, 'auth-token', 'a9adae261a6a246781477e549eaec77c4184b2fdb226d0ccfff6c752f1e18c53', '[\"*\"]', NULL, NULL, '2026-05-04 05:31:56', '2026-05-04 05:31:56'),
(42, 'App\\Models\\User', 1, 'auth-token', 'da6cfb26118ad2854a6a3dd0359e5d22dfd96ceacf3b0754a49aa61ba63158fd', '[\"*\"]', NULL, NULL, '2026-05-04 05:36:37', '2026-05-04 05:36:37'),
(43, 'App\\Models\\User', 1, 'auth-token', 'ae5ca08763ffd6aef83d23847a70d6a18519dd0131822253424cdd947c4e9d85', '[\"*\"]', NULL, NULL, '2026-05-04 05:42:13', '2026-05-04 05:42:13'),
(44, 'App\\Models\\User', 1, 'auth-token', 'a7541b64e414b1697aa97281396848ce2b862fbe738d93643739233b9d2b4086', '[\"*\"]', NULL, NULL, '2026-05-04 05:49:52', '2026-05-04 05:49:52'),
(45, 'App\\Models\\User', 1, 'auth-token', '06863a90a6fce9aa93e8b970f7649c0fee4d38cd7c8ab1aa0fea62f895405937', '[\"*\"]', NULL, NULL, '2026-05-04 05:56:33', '2026-05-04 05:56:33'),
(46, 'App\\Models\\User', 2, 'auth-token', 'ca008d66e53a139396d2856ad0d3de1dbd34c71956a49b1bac9a95a1f1c070c3', '[\"*\"]', NULL, NULL, '2026-05-04 05:57:48', '2026-05-04 05:57:48'),
(47, 'App\\Models\\User', 10, 'auth-token', '53640469d273626f6bc9c737050c093186ae9b8022053a959413333bc522460b', '[\"*\"]', NULL, NULL, '2026-05-04 05:58:27', '2026-05-04 05:58:27'),
(48, 'App\\Models\\User', 1, 'auth-token', '8897a04744c3cd7bbb97a9259df841aa4295a63a51403e24b85980eba78ad524', '[\"*\"]', '2026-05-04 06:10:17', NULL, '2026-05-04 06:10:07', '2026-05-04 06:10:17'),
(49, 'App\\Models\\User', 10, 'auth-token', 'd9228d1bee5e7777472aae20f0e14d6c9679ffe0274f6d656de52ee806db3a23', '[\"*\"]', '2026-05-07 03:00:48', NULL, '2026-05-07 02:59:03', '2026-05-07 03:00:48'),
(50, 'App\\Models\\User', 2, 'auth-token', '354ce1d21ca43ac160013ee337c90b26d3d26ee30b757276b35f06ccfd9fe2e8', '[\"*\"]', '2026-05-07 03:01:31', NULL, '2026-05-07 03:01:14', '2026-05-07 03:01:31'),
(51, 'App\\Models\\User', 1, 'auth-token', '9bb581c1e0833142901d2a59025dda55e401f5cedc7e9acacc572014feb97c8b', '[\"*\"]', '2026-05-07 03:03:05', NULL, '2026-05-07 03:02:19', '2026-05-07 03:03:05'),
(52, 'App\\Models\\User', 10, 'auth-token', '0609ec423c607acbd27ec555fb94b2b81b73133d37b0c72a98940b50b3d9d971', '[\"*\"]', '2026-05-07 03:09:10', NULL, '2026-05-07 03:07:04', '2026-05-07 03:09:10');

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
('0190cXO0fmE80tZ6hXYvP0SOAWA1SzAcuoCP8FO4', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJFNXhZMkFtanVHYUJZTG1QN0p3QTVDRlZxUTRSZ3J3TFFRNjRNUFdBIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778148491),
('0lkrGjABvK7qNjh8KKbbr3DNtIqSzewmE7WwC7Vj', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJyMmtJTjFkNE1kM1h5aGpFcHZnM1lhTTgxUFAyUWJEN2ZkMGxJeGs2IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9hdHRlbmRhbmNlXC9oaXN0b3J5Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148466),
('0M5fjh1mqUHyzecgQrCfiSKOEJqRwl3SbyMJ3N1u', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJQVTY0RUdkTFpaa0NXa3RxUzlUaGFKdjBxdkFRRUpweWl2dGtQREwyIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZXBvcnRzXC9hdHRlbmRhbmNlXC9qc29uP2VuZF9kYXRlPTIwMjYtMDUtMDcmc3RhcnRfZGF0ZT0yMDI2LTAzLTAxIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148152),
('0QPi3CvzUvZwsESCLAZBwUG1xAr0qNzvLCUgMQxP', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiI1dWloc09nUkoycURjelpTdDJ4ZFVpZjVabWhvUTVnRkk0MXJ3bUo1IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZWNlbnQtYWN0aXZpdGllcyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148185),
('1MuM1Py6yf4pQDb4WS7QD2tMjMHHfNthmgijnccp', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiI0UXFlNUZnaTlSbUhlbDl0WnJoSWpEcXozZVJjSURnYTM2YTZGZnNjIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZWNlbnQtYWN0aXZpdGllcyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778147920),
('1OKD0DylpyvXXisSdcwO8LbZYjLVnWcXmlfO6h09', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJZSWtnUU9MSW9zMTNBODBWemlhS3NCdjFlSzVma3BkSU5DbEVxUVZ5IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9hdHRlbmRhbmNlXC90b2RheSIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148433),
('4oZsR5IRQGjRkKcpAhcvMLqr9a6mbuvfdCtZz0d7', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJPRzZ3RjZueEdMVDlCVGE2TXI4SWdNSFVEMjRWR3Y2TmFMeUFrSDdMIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148074),
('5fL39P198wfmJVEine7TIdfD0eMB3NOjuRyY8AtY', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJsT3F0bm52WDMwMTRJVUpiMnNYZU5yNG1xdDVVT2I5RmZTWDc3U3dwIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9sb2dib29rc1wvcmVjZW50Iiwicm91dGUiOiJsb2dib29rcy5zaG93In0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778147947),
('6GPdhDaGpCFj7AkXbmcdf2DVF5xhoz8nPkKd5wEw', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJHamRIdHhRbVlEU1huSExpTkFRaFBCSmdabHhOQ29BYzAyajYyWUxsIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC90b3Atc3R1ZGVudHMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778147883),
('6SmrZKvJXo0GX5oPQFRSYhvNQiGVg7XuaH6CHUOd', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiI2YTdCamlCY0J4aEZIa2o1R1lpOXBiWk5pSkpBYmdkTldBQmIwZHVDIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9hdHRlbmRhbmNlXC90b2RheSIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778147950),
('7pPFHItiRJ3cVMCWDsjSYo1RLjmjSI2om12bxSWR', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJRNHdnUmFRbEdLejFxajBQMEthYllLSkJNYUo2RExpNVMxaXlxUklWIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9hdHRlbmRhbmNlXC9oaXN0b3J5Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148017),
('86aIRYR3LHBhCFSPPziGit3CA2S0AQnEs7OEv1WC', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJSNkRFZzBoWEtpTmZlMzB1M2JCOXhpd2lmY0ZBR25Va3NUeWNiRUZ1IiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148193),
('9FribQj0ZvN8iO1viic2djvfcPMGkOA4GrAMIyqE', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJBaWE1TUx3V0dSV1pkUFpTSFJCM2xidUdDRHpQc3ZTN0NaY0M0WXFwIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2NvbXBhbmllcyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148147),
('9i8eBGaGWdbHbFsad5xrSqW1zXN1aDcVDPYEHI6S', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJFeTdCdkw2ejN2WmJ4enBiMVlQN0ZqdlNycTg0dDRFUWtqNjF4QkcxIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9kYXNoYm9hcmRcL3N0YXRzIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148143),
('AGRLK74XivRPw6ngFBKLHtmnkHCTFmrG9sWzyEVE', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJ5dm9ycjM4Vmxpc29oOEQxSndtbjVYY0xXeExhVWpHUnIxaFZlZG84IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC90b3Atc3R1ZGVudHMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778148146),
('b4goOwJVThWXuGt9idGQkvw1DQvpPwhzd1wYe4GR', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJ0MWVyRDJwWjhMUkN1ZXBJTG4xMGFtek1vQ2lQSkpSSW43aWhHb3hTIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC90b3Atc3R1ZGVudHMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778147920),
('bkhwoXHxr2P3vuHun654aGsRPEzhw0iAfuwXaGDn', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJ1MEhPSkI4OFBHTFhVbERJWTNuUjR3TjVvU29Va1BFWE1ycThvNGZrIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778148045),
('CFZw0MhiRcnu2Abbj1mKMLnwANzt9h4920UKsQ2p', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJmN0dyaXNMZlQxRHczdlZJN09pNzhkYXhDUU1LY2ZaQWpjeW9ZSWNqIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL21lIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778147880),
('CsucJRrCkCYxF21GcLPYLL5Ui3skUgktUCjC9W5Q', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJ2dTdwcU41eTNMbkRRSklMYVJNeTNLaFdYMFV1MHN1MXhSdHFYOE1pIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778147902),
('DmD0yd6tOmREzQbeE4nj9MovgilIEx47uxMrhm5T', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJkZUpjc2F2QkVsWkU0YTNXOHBta1hDQWxDUUtBRHRBdG8zOEs3cXBrIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778148005),
('DRleixJ9BBKFGbavOJ6ujW52HkL4Amz0mHTOLefZ', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJWRUpKc2hrZnJOemJHVFJLNERScExiNmZrUUsxMzhHZDM0UzBlQU50IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL21lIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148435),
('dvaQFCERxnQphMkSISSjyFWIjCt0DZPG3PEN16hN', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJmdkd0eWVhazBHaGU0MGdhQmVxenR0ZTAxUEtNQ2Q5Qnl3bVk3YVRHIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778147948),
('EhbPPT0IbBGEpDmKr7xJThA3vKds75e5PkEFHawp', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJBcHozUDlvWU5sVnVmS0ZmWGFJd2x0WW1TWkFDWmFNVnc4dnlFQmExIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778148039),
('eJy9H01bEoqeRA7qYq95QBk4Y3heIIe17nGxNyEr', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJqTm15ZUNyeXc4ZUgyMXl4U3RoTmVwRXBvM0h1RWNZTW55QTFBNFNUIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9hdHRlbmRhbmNlXC9oaXN0b3J5Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148048),
('EunOOVI0GnTGWsZGJlfGmPddVW6KHGCWyyFilWJ3', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJHMWRCelJ5N09xT1dkNzFiZWl0a0k1TmpFOWlUdHNLdkRzSng4ZVdmIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148013),
('f2lPqUtBGX3KTKKnZf3Qyvkh1BlZCf0NziqDaA4A', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJwbkFEVWk5cUF0eU1jc3ZPdU5RajVWVkdsWUhuV3RZVGhEcXFpZXlJIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778147975),
('fCn3g5GUafIayNuNWDezENvrJJCdySKAWbnGxXCi', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiI4U1ptanZNcWdpMmlRVU10TDdSWmI5RFlSZlBlRGU1SVNoZ0Q5ODlIIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2d1cnVcL2xvZ2Jvb2tzXC9wZW5kaW5nIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148080),
('fdxGcc9oqJ7cBzdAEpBMDLnNmqOCzP9jTLbrzeif', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiIwb3Y0a2luWXQxbFdhSVhxS01DV0RQU1pQWVpSdFpmMmw2aEZ0aGdUIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9hdHRlbmRhbmNlXC9oaXN0b3J5Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778147952),
('FTMJVeqekCexlGSuRYpwBdUhtyzmbJYu8jfSIoht', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJhQ001VENQSUg0VEhqMWNSelNRQjFZYW9lTTJSaVpIUURJWVNncWd6IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2d1cnVcL2F0dGVuZGFuY2VcL2NoYXJ0P3BlcmlvZD13ZWVrIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148082),
('Gm5aMsjajsq4oLGX7io477LR4HQD25bq7W9waSkk', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJLVUd0ZXlTWENPVzhCMkFValg2bWg2Q2JRYVo0d1Z2TnZ1emxJYm12IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZWNlbnQtYWN0aXZpdGllcyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778147882),
('GYFwJyPCRt4ANAodvVeDlxLhAhi9pFS0evsjj0zA', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJGR0l2TW1hOGV6cER0R3YyVE9MblBPUkplNlNCcHdyMFZiM3dWMDZxIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148424),
('H8WN34yaHJr3FFstLo0sxYTxMoooj8hsmhDqj3Dr', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJtaGtzcmpaOHFGNUo3d0hta2VoempWTGtVU0E1MVFKSHpyVDJkaVU1IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778148171),
('i7jFCdC3sR0UK1TuF7rD8RtflhNOUsNX0sFa14M7', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJlbUM1V0dKb3dXVm43QVVjcnZkc1hkclVPQnFzY25ISndycEV4SGRGIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZWNlbnQtYWN0aXZpdGllcyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148146),
('ietjEW1CkvOr4reVehsLS3oE9aAg498glU83GrlP', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJuV3BSVkMxOUlQVG1zR3dZZ0Nlckp0SDB1dVRxUGZxTnk5TlpHYTE5IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778148012),
('ilBkdtSlloYYwkUlNKSdq5KY6U9nedITykLRbV1w', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJZOThyR0x3SER4T2VzaTlQQTlaQjdHSndHVEF6UmplS3lMTkV0Q0NFIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL21lIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148010),
('iN16Sz1o4CBNXcnjNpnOR7QN3WlxnBrd8JrMweXQ', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiI5Qm1IMERMZVoxWWw4S0taaGhCcmlnZExwNmlkVWJ4UXdORlRIb1RjIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9jb21wYW55Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148430),
('izAOiCroU4o7I9qByVER5vlOGwSb3U9z2zgdGb6U', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJEU0c3R2FvTkV5a0NhT3BVdjN2M2JJcmxTT1FVbUM2Z2ZucHQwcERoIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778148436),
('jrYY6yfNWBG8XaTas0nSyTogJMMX1CD0cZIRQOhk', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJYUG9hUjM2c0pzSVc2c1hTVlBMWVlURXF1ZFBHM28xakFpMVRFdDVGIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2d1cnVcL3RvcC1zdHVkZW50cyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148081),
('k12gtG1sojbHGInDKiUTblSrnBQPtTeVeqqojlxO', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiIwOHphMGxOaVZ2dlRINFdtZmdBWVZCVFBLMGpjTkNGTmI4ZXhic0Z1IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9hdHRlbmRhbmNlXC9zdGF0cyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778147881),
('KDZtbKowCmMsSFUQOFAUfwIP0UB0GcM3CLjCLMhc', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJ2UEpBeEhMQWNiWUFFRm40d2VwUFVsaDJXNFlCQnp6M3B3MXp3MWNUIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9jb21wYW55Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148045),
('KO6MzD5o9YfSQTSWYKx4QQxvCAggSw0mqs6cXcVn', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJFWUN6Q2FXMjZ3Vk5VZVVpNzVWeklRaldmYzJEczFvSXFzak10T012IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9kYXNoYm9hcmRcL3N0YXRzIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148149),
('Kys1ctLarSxb0W0RMaYuabHGWjuecBRI3i0DSjRT', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJuZnY0b1l1bjc0cEh2eDdOSjJTYmNXc2xXdW1xanA5ZUxrREFVSUVoIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148432),
('leZTgRpivTFXGSFqErgj1uELKPACZo2Y16jfdZVH', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJ3ZlI0dWpQTGJnYlFnczZUM3BkbVZ5VGU3QkVlV203U2I3MDFqN2NIIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9jb21wYW55Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778147949),
('lTTSxyF0v0P7sVonuqUzxJpVy4jtRW69EfJJNSFS', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJlUW1tektndTY4ODdGMnRHb3BhcXpocUtsR2E4Y0Ewb3hFWjVJQlVYIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148134),
('lxXS2InklQjoAA1qQ3BShpE5joM7bUnMifGnXdgl', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJhaVVaUEoyeDJjTERNMXJENEN4YUZBZ1dBRkpHcUpvMmpCWkRVWlRtIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL21lIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148044),
('m9rrO7MCT74NpyQi3O6gy8wwN2tvMIq8QDB5CCA7', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJTVkg5QmhMQ3RsaER6amFuTkd0M2xwdzZxY3BGM1hJMmJUaTQ3c09kIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9hdHRlbmRhbmNlXC90b2RheSIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148014),
('mBmPPwvIA6fXGdMNktXC4WI1dCQkinBBIL51rS0L', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJOT1Z0Uk1vQUxVR01QTk5hUXFnV3BQN3FVVERSRVRBTENSajBPMFhHIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9jb21wYW55Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148462),
('MI3wbC2xMCYxHCqO1siXfdsqu4ANaNZ6DnJZ602j', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJFamM4czZXS1l3T0JVNFdwbkJtemNXdlRHaGRqazBNTjh6U2dwMzIzIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2d1cnVcL2F0dGVuZGFuY2VzIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148084),
('NI0nYEXvt8fxfSgq6NkzSk7mWIWUqsgmpQXCWzSc', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJZbWNsOFZYaFRBdDJVejg2a1hhN215ek9wNXR4WWRYQmhkbGtWQmJsIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9kYXNoYm9hcmRcL3N0YXRzIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778147918),
('NMqYyPnTL9O4E1jD1jJaAr87aMgDfPu8baaAOK22', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJ0UVJTUHNwQWZpN0o5THUyaDdOQTFHZXFSOFZ5NmNEUm1iSzBMMzlCIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9hdHRlbmRhbmNlXC9zdGF0cyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148143),
('O2bedXj6XgBrrnoc3WSDXOccE2GgUArMtupXL8HY', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiI4UU1RdXBoa0RvVWhpQmt0U1ZGU1RnVzFqNXlLYjFyTFk2MWJNTTBxIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9hdHRlbmRhbmNlXC9oaXN0b3J5Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148439),
('oE1AyEHUEYe0VMpmpqsMe2Cr8Q8au3gPRz8uZ4I5', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiIySXVybFZWOFNLZUNkNFpOUnhNZ3k1TDhKVXhmUXFNOURpYjBxUGQyIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC90b3Atc3R1ZGVudHMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778148186),
('OqUk31QcddqcGTXa9UcQH8LH5bnqUMIabRIgIg6e', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJHcUxZNURMb0dNRTBFdWxHZnlXNUUwYUtITXFkOWRIRUdGZ1BRem9ZIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2d1cnVcL3Blcm1pc3Npb25zXC9wZW5kaW5nIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148081),
('otTceyymzW8S2mvmADhAgddKjLG0mce40byUk4bo', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJLVndRRFdwZGVITWFISnA0UUdZNFVHeHp0Y2M0ZDlsb3pDTWtIRHVyIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778148429),
('OV90LySR4lEje8R4MNcI4HRTQ84heRAkc7M55eDZ', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJtOHVCRzMzVW8zeDZPQXZ6QWJUT1lPeHlXbEN2cUU2TnV1TENuNVdLIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778148550),
('pFlDergPs2ukS02nAprGVvtv75VdhdJ1klSuiSWk', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJubW9FaEpYYWc3OVloVGZCUE1YRTN2SFRKNnVSazFCSnZhMndwS1BjIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9hdHRlbmRhbmNlXC9oaXN0b3J5Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148019),
('piUvI2NcvJZHs7zwYQdIhafvODU7Pm3bHM2fLhTb', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiI4TGJFVlBxTk5JcUNvcGZWTkpqQzF5S0NYQkZvWUplOE5vRjhSRDF1IiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148139),
('qxZxYPJxCQfPlwnUKb4UtgtgRHvqvkJ7IkQVQVPu', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJNR3ZaMEdNSWlPRXpabUlKekZaNlJTSzF5MTd4RFNtdnU1Q1hVRlQ5IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9sb2dib29rc1wvcmVjZW50Iiwicm91dGUiOiJsb2dib29rcy5zaG93In0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778148429),
('rnJ4iEk4vLob4YNp8C0QUwLbTv2BY0YZCpgoV4jp', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJHc0NoTlIzOTA0QTE5dFdQeW5ZVTZGWWNNSzI3d0tMSEd6VllCUURyIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778147923),
('s2C073LKVZTD0cKSIfKtw2lSO5NYGqUoCauZKlu5', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJybllWdU15TjRCdVVvMHp2S0xsQXo4NW45SFhoV2NpYlFMYWYxc2ptIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2d1cnVcL2Rhc2hib2FyZFwvc3RhdHMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778148079),
('SHnN1HdWLcYn6WiFS70ZutBwex34C5NjBY5Hb1XP', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJWcVNkcmxLaVNqeDN1Um04M0NUdW9XRER4SkZIRXZBN25ObU5oTFVwIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9jb21wYW55Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148011),
('sn6psjXiVUJ150HQp6QClLptd0S4Wbj8bVA02my7', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJmQ2JYWjI1U1NldGdxbEVTRU44Rm1pU0R6QW1CMFRIc2dxNkszaHBNIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9yZXBvcnRzXC9hdHRlbmRhbmNlXC9qc29uP2VuZF9kYXRlPTIwMjYtMDUtMDcmc3RhcnRfZGF0ZT0yMDI2LTAzLTAxIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148151),
('SsSTNfXzAN5hlwqtnf4cS11jayD1yEF8Yd9xxkvf', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJGRHlzRmxubEdxMXVxYU1LdzJoNHhsWDVQS3JzYlo5b25Qa2ZlQk4wIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9hdHRlbmRhbmNlXC90b2RheSIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148047),
('TE1bvN4jo1ZomltA4Y2oaQF4Bg8mOStkBjYbz37h', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJaQUJtRkFMZGU1TzFqR2VDSXB5R0ZIdnRaWWtxZHR4eTBGQVoydmtGIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148068),
('tfzSRtGQRZmOeuM7tkWCMlDUOPBCmY7OOxzXcife', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiI2a2lpc0I0ZEFPb2Zyc09qVFowYU5qSTFmekFvQkhKUkdqS25SUDVOIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9hdHRlbmRhbmNlXC90b2RheSIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148016),
('tiJLdsHvegbN87KWGeYRncLGbgSaUUdTGsR7e0km', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJBTmtESmdLMThLNU5XS1p3a2Z4ZFhIUHRCSDFpSXBoTEd0UTZJSzJqIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9tYXBcL2NvbXBhbmllcyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778147885),
('u61Am0lmVzx9LkKeGHaRFcJSNzdhclSsbmXTsmgu', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJmd0lWQ01xVjFZZUNMNmRtUWlIekhRVmRuamJCZHNIWG1vVHRqWWtxIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9kYXNoYm9hcmRcL3N0YXRzIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778147946),
('UIlY7qT51XFbOICWuS7MqPT3SOuQTsvTgoOq10st', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJ3T3h5NHZxNWoxUmlIdDQ0dEw5YTJBMTB1cWhwZFZRR2tKcHZYaWZ0IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9zdHVkZW50cyIsInJvdXRlIjoic3R1ZGVudHMuaW5kZXgifSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148148),
('V1nVBxSiGdz7sXhgpZWMUuq7IGNNrsuMpncIpQzy', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJUaDZwWG1kVzJmQWY0eFZsT0hnNHViZThKQmJtWjNJMFd3SUwwbU5VIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9hdHRlbmRhbmNlXC90b2RheSIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148438),
('Vcn63oxANj2QWeZFdYuwF6otkYcgU1IfVNNSQJqp', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJjbk9pZnhtS3UxdFd3RTBIUHAzajRvbmpNOWcxRHZRY3M3T1llU1BzIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778148463),
('w3pEM4R0VF0hY5GP7PyEdFlJvsSCA1e3fFpf5tcE', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJMS0EybnhVWDJ4TEhRblJib0ZLUzcxS045cDdtWkdWZHh2SGV4QktrIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9kYXNoYm9hcmRcL3N0YXRzIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148427),
('WsBQ6Ri1wryB71rS3W6U8MzgEWL40hGUcWXgWQFL', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJ1ZTd1dWJjdllpRm1za243c0xoYTlVOVFUdzBYUnVSV2pHZHdxWk1lIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9jbGFzc2VzIiwicm91dGUiOiJjbGFzc2VzLmluZGV4In0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778148148),
('XE9Al7Qycx06RhIFMaFmmm3CuYkmhqQtg1RH0949', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJQS1lYOGVvVG5xRU40cnVYSEcwRllVcFNYNlpMNnpFQ1dSOFZYdGFBIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9hdHRlbmRhbmNlXC9zdGF0cyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778147919),
('XludFpCv1MFqoOOMXWWBNWuXLcR8aKVI45oslUrm', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJNSmtLZWk4bnVGclpMenhBemlnMG00U0YyUFVPcFBLWjE1MnlITEdCIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9hdHRlbmRhbmNlXC90b2RheSIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148464),
('Xm0EA0EadCQ0eKtmC2Kc1lBZKESIK2MTJiuIm5rQ', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJiMzYyZjFSZVowaW82YmJqdnQzdFdmS1p1UHBSbHp4ZXY2U1JxRTAwIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL25vdGlmaWNhdGlvbnMiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778148521),
('XobmlH5NiLuvkDMwIXLsSGA27TkKOHmt6cnmi2RK', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJqVUZNRm5lY0dsc2FtVUd0ZWN1ZEJwQlJFUG5zbUhyYzFLakdNZDBPIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2d1cnVcL2F0dGVuZGFuY2Utc3VtbWFyeT9lbmRfZGF0ZT0yMDI2LTA1LTMwJnN0YXJ0X2RhdGU9MjAyNi0wNC0zMCIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148091),
('Y7p8lYCuZ90WyK2u4tT2m00q4HSLa9kuhkmSJbMs', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJCZlBDeTYzQUZUeklDM3FEU1h3QXh2V0s2N1E2QUN3QXY3OTBBVHBJIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778147943),
('yESvtUqOZiu2qerz4fm76iH18gxUXo3QpjDlrMPB', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJhZFVUV2p3bUtDY0lseHR3NXU4d3M3OWtTSXNqMmt4a3l3UG5OUjltIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2d1cnVcL3N0dWRlbnRzIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148084),
('YfCGuMaEWqWHbMU2O7hxPMFCmgzoaYBnrqn2nIvw', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJjOFZrWTQ1bmF1YWxqUklsMnozRUJTWmgwTTJhMGJvSVpRWnh2MURzIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL3Npc3dhXC9jb21wYW55Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148436),
('yovDZlzbxOGzYx8Am0J5f1NLG9UXjUSV5FwCd4qX', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'eyJfdG9rZW4iOiJ3anFabzdaTTBJT05qTlhHYXBmV21HVjJiRG1LYW44dHZnTWFDa2dwIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL21lIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148462),
('ytwxoR3dL0BmDBXSiiUUGF17UlpXjeS1Wq9xyho9', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiI4UWFOSURqMEZQRXkwYmFYTEtQQzdYeWxYNzYwRkJFZHNCV2tmNFJTIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9hdHRlbmRhbmNlXC9zdGF0cyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1778148185),
('z57YOJHchICU55k4RQWefIq4WKQjsFdWsmfWGEwi', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJOOVlSSHFZTFRPVnVZMGMwaUdCSTkwTGs0ZHVEUkxWRnJXeDBsb1pBIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9kYXNoYm9hcmRcL3N0YXRzIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778147881),
('ZgJVZdpSU7lcvkZDEecNQGGO63hltY617i6tl7tu', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiI5cjdlOUVNVXphVE1xTDJMdHI4Yk9KcGR1dkRwSld2VnhpaHZTMDJCIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hcGlcL2FkbWluXC9kYXNoYm9hcmRcL3N0YXRzIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778148184);

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

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
