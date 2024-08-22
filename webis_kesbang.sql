-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for webis_kesbang_kaltara
CREATE DATABASE IF NOT EXISTS `webis_kesbang_kaltara` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `webis_kesbang_kaltara`;

-- Dumping structure for table webis_kesbang_kaltara.dasar_hukum
CREATE TABLE IF NOT EXISTS `dasar_hukum` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tahun` int NOT NULL,
  `deskripsi` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tahun` (`tahun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table webis_kesbang_kaltara.kode_instansi
CREATE TABLE IF NOT EXISTS `kode_instansi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama_instansi` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nama_instansi` (`nama_instansi`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table webis_kesbang_kaltara.konfigurasi_aplikasi
CREATE TABLE IF NOT EXISTS `konfigurasi_aplikasi` (
  `id` int NOT NULL,
  `pengesah_spt_id` int DEFAULT NULL,
  `pa_id` int DEFAULT NULL,
  `skpd` varchar(255) DEFAULT NULL,
  `lokasi_asal` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pengesah_spt_id` (`pengesah_spt_id`),
  KEY `pa_id` (`pa_id`),
  CONSTRAINT `konfigurasi_aplikasi_ibfk_1` FOREIGN KEY (`pengesah_spt_id`) REFERENCES `pegawai` (`id`),
  CONSTRAINT `konfigurasi_aplikasi_ibfk_2` FOREIGN KEY (`pa_id`) REFERENCES `pegawai` (`id`),
  CONSTRAINT `konfigurasi_aplikasi_chk_1` CHECK ((`id` = 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table webis_kesbang_kaltara.pegawai
CREATE TABLE IF NOT EXISTS `pegawai` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nip` varchar(50) NOT NULL,
  `nama_pegawai` varchar(100) NOT NULL,
  `jabatan` varchar(100) DEFAULT NULL,
  `pangkat_gologan` varchar(100) DEFAULT NULL,
  `kontak` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nip` (`nip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table webis_kesbang_kaltara.rekening
CREATE TABLE IF NOT EXISTS `rekening` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tahun` int NOT NULL,
  `nama_rekening` varchar(100) DEFAULT NULL,
  `nomor_rekening` varchar(50) NOT NULL,
  `jenis_rekening` varchar(50) DEFAULT NULL,
  `kode_instansi_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tahun` (`tahun`),
  UNIQUE KEY `nomor_rekening` (`nomor_rekening`),
  KEY `fk_kode_instansi` (`kode_instansi_id`),
  CONSTRAINT `fk_kode_instansi` FOREIGN KEY (`kode_instansi_id`) REFERENCES `kode_instansi` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table webis_kesbang_kaltara.sppd
CREATE TABLE IF NOT EXISTS `sppd` (
  `id` int NOT NULL AUTO_INCREMENT,
  `spt_pegawai_id` int NOT NULL,
  `nomor_sppd` varchar(255) NOT NULL,
  `tanggal_sppd` date NOT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nomor_sppd` (`nomor_sppd`),
  KEY `spt_pegawai_id` (`spt_pegawai_id`),
  CONSTRAINT `sppd_ibfk_1` FOREIGN KEY (`spt_pegawai_id`) REFERENCES `spt_pegawai` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table webis_kesbang_kaltara.spt
CREATE TABLE IF NOT EXISTS `spt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nomor_spt` varchar(255) DEFAULT NULL,
  `kategori_perjalanan` enum('DD','LD','LN') NOT NULL,
  `tanggal_spt` date NOT NULL,
  `perihal_spt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `tempat_berangkat` varchar(100) DEFAULT NULL,
  `tempat_tujuan` varchar(100) DEFAULT NULL,
  `tanggal_berangkat` date DEFAULT NULL,
  `tanggal_kembali` date DEFAULT NULL,
  `kode_rekening` varchar(50) DEFAULT NULL,
  `pengesah_id` int DEFAULT NULL,
  `generate_sppd` tinyint(1) DEFAULT '1',
  `status_spt` enum('pending','setuju','ditolak') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'pending',
  `signature_data` blob,
  `status_pengesah` enum('Kepala Dinas','Plh. Kepala Dinas') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pengesah_id` (`pengesah_id`),
  CONSTRAINT `spt_ibfk_1` FOREIGN KEY (`pengesah_id`) REFERENCES `pegawai` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table webis_kesbang_kaltara.spt_pegawai
CREATE TABLE IF NOT EXISTS `spt_pegawai` (
  `id` int NOT NULL AUTO_INCREMENT,
  `spt_id` int NOT NULL,
  `pegawai_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unique_spt_pegawai` (`spt_id`,`pegawai_id`),
  KEY `spt_id_idx` (`spt_id`) USING BTREE,
  KEY `pegawai_id_idx` (`pegawai_id`) USING BTREE,
  CONSTRAINT `fk_spt_pegawai_pegawai` FOREIGN KEY (`pegawai_id`) REFERENCES `pegawai` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_spt_pegawai_spt` FOREIGN KEY (`spt_id`) REFERENCES `spt` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
