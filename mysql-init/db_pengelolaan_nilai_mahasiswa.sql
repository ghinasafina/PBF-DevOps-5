-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 13, 2025 at 06:45 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pengelolaan_nilai_mahasiswa`
--

-- --------------------------------------------------------

--
-- Table structure for table `detail_nilai`
--

CREATE DATABASE IF NOT EXISTS db_sidangskripsi /!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /!80016 DEFAULT ENCRYPTION='N' */;
USE db_sidangskripsi;

CREATE TABLE `detail_nilai` (
  `id_detail` int NOT NULL,
  `id_nilai` int NOT NULL,
  `nilai_tugas` decimal(4,2) NOT NULL,
  `nilai_uts` decimal(4,2) NOT NULL,
  `nilai_uas` decimal(4,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `detail_nilai`
--

INSERT INTO `detail_nilai` (`id_detail`, `id_nilai`, `nilai_tugas`, `nilai_uts`, `nilai_uas`) VALUES
(2, 1, 70.00, 80.00, 90.00),
(3, 2, 75.90, 85.00, 88.00),
(4, 3, 77.80, 76.80, 97.00),
(5, 4, 80.00, 90.00, 71.00),
(6, 5, 69.00, 70.00, 88.00),
(7, 6, 70.70, 76.00, 76.00),
(9, 8, 74.00, 83.00, 84.00),
(10, 9, 70.20, 92.50, 78.00),
(16, 11, 80.00, 70.00, 90.00),
(17, 13, 79.00, 86.00, 74.00),
(18, 14, 80.00, 80.00, 80.00),
(19, 15, 70.00, 70.00, 70.00);

--
-- Triggers `detail_nilai`
--
DELIMITER $$
CREATE TRIGGER `hapus_nilai` AFTER DELETE ON `detail_nilai` FOR EACH ROW BEGIN
    UPDATE nilai_nilai
    SET nilai_akhir = NULL
    WHERE id_nilai = OLD.id_nilai;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `hitung_nilai` AFTER INSERT ON `detail_nilai` FOR EACH ROW BEGIN
UPDATE nilai_nilai
SET nilai_akhir = (NEW.nilai_tugas + NEW.nilai_uts + NEW.nilai_uas) / 3
WHERE id_nilai = NEW.id_nilai;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_nilai` AFTER UPDATE ON `detail_nilai` FOR EACH ROW BEGIN
    UPDATE nilai_nilai
    SET nilai_akhir = (NEW.nilai_tugas + NEW.nilai_uts + NEW.nilai_uas) / 3
    WHERE id_nilai = NEW.id_nilai;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `dosen`
--

CREATE TABLE `dosen` (
  `id_dosen` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_dosen` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_telp` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `dosen`
--

INSERT INTO `dosen` (`id_dosen`, `nama_dosen`, `email`, `no_telp`) VALUES
('ABD', 'Abda\'u', 'abc@gmail.com', 123456789),
('LUT', 'Lutfi', '476@gmail.com', 947432567),
('ROS', 'Rostika', '456@gmail.com', 678912345),
('RYD', 'Riyadi', '234@gmial.com', 987654321),
('WHY', 'Wahyu', '789@gmail.com', 123987456);

-- --------------------------------------------------------

--
-- Table structure for table `jurusan`
--

CREATE TABLE `jurusan` (
  `id_jurusan` char(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_jurusan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `jurusan`
--

INSERT INTO `jurusan` (`id_jurusan`, `nama_jurusan`) VALUES
('JKB', 'Jurusan Komputer dan Bisnis'),
('JREM', 'Jurusan Rekayasa Elektro dan Mekatronika'),
('JRMIP', 'Jurusan Rekayasa Mesin dan Industri Pertanian');

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `NPM` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_mahasiswa` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `alamat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kelas` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tahun_akademik` int NOT NULL,
  `id_prodi` char(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `mahasiswa`
--

INSERT INTO `mahasiswa` (`NPM`, `nama_mahasiswa`, `alamat`, `kelas`, `tahun_akademik`, `id_prodi`) VALUES
('230202020', 'Alissya Iklima', 'Jl. Bromo', 'TI-2A', 2024, 'TI'),
('230202021', 'Ghina Safinatunnisa', 'Jl. Munggur Timur', 'TI-1B', 2024, 'TI'),
('230202022', 'Muhammad Rifandi', 'Jl. Ahmad Yani', 'TPPL-2C', 2024, 'TPPL'),
('230202023', 'Ilham Budimansyah', 'Jl. Benur', 'TM-2B', 2024, 'MESIN'),
('230202024', 'Yovi Tito Budianto', 'Jl.Srandil', 'TI-2A', 2024, 'TI'),
('230202025', 'Adimas Prawit', 'Jl. Sudirman', 'TI-2A', 2024, 'TI');

-- --------------------------------------------------------

--
-- Table structure for table `mata_kuliah`
--

CREATE TABLE `mata_kuliah` (
  `id_matkul` char(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_matkul` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sks` int NOT NULL,
  `semester` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `mata_kuliah`
--

INSERT INTO `mata_kuliah` (`id_matkul`, `nama_matkul`, `sks`, `semester`) VALUES
('DIP', 'Desain Interaksi', 2, 3),
('K3', 'Keselamatan Kerja', 2, 3),
('MATDIS', 'Matematika Diskrit', 2, 3),
('PBO', 'Pemrograman Berorientasi Objek', 2, 3),
('PWEB-2', 'Pemrograman Website 2', 2, 3),
('RPL', 'Pekayasa Perangkat Lunak', 2, 3),
('SIM', 'Sistem Informasi Manajemen', 2, 3);

-- --------------------------------------------------------

--
-- Table structure for table `nilai_nilai`
--

CREATE TABLE `nilai_nilai` (
  `id_nilai` int NOT NULL,
  `id_dosen` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_matkul` char(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NPM` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nilai_akhir` decimal(4,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `nilai_nilai`
--

INSERT INTO `nilai_nilai` (`id_nilai`, `id_dosen`, `id_matkul`, `NPM`, `nilai_akhir`) VALUES
(1, 'ROS', 'MATDIS', '230202022', 80.00),
(2, 'ABD', 'PWEB-2', '230202022', 82.97),
(3, 'ABD', 'PWEB-2', '230202024', 83.87),
(4, 'ABD', 'PWEB-2', '230202023', 80.33),
(5, 'ROS', 'MATDIS', '230202023', 75.67),
(6, 'ROS', 'MATDIS', '230202024', 74.23),
(7, 'RYD', 'SIM', '230202022', NULL),
(8, 'RYD', 'SIM', '230202023', 80.33),
(9, 'RYD', 'SIM', '230202024', 80.23),
(10, 'LUT', 'DIP', '230202024', NULL),
(11, 'LUT', 'DIP', '230202021', 80.00),
(12, 'LUT', 'DIP', '230202022', NULL),
(13, 'WHY', 'PBO', '230202024', 79.67),
(14, 'WHY', 'PBO', '230202020', 80.00),
(15, 'WHY', 'PBO', '230202025', 70.00);

-- --------------------------------------------------------

--
-- Table structure for table `prodi`
--

CREATE TABLE `prodi` (
  `id_prodi` char(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_prodi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_jurusan` char(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `prodi`
--

INSERT INTO `prodi` (`id_prodi`, `nama_prodi`, `id_jurusan`) VALUES
('LISTRIK', 'D3 Teknik Listrik', 'JREM'),
('MESIN', 'D3 Teknik Mesin', 'JRMIP'),
('PPA', 'Pengembangan Produk Agroindustri', 'JRMIP'),
('TI', 'Teknik Informatika', 'JKB'),
('TPPL', 'D4 Teknik Pengendaliaan Pencemaran Lingkungan', 'JRMIP');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_nilai`
--
ALTER TABLE `detail_nilai`
  ADD PRIMARY KEY (`id_detail`) USING BTREE,
  ADD KEY `id_nilai` (`id_nilai`) USING BTREE;

--
-- Indexes for table `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`id_dosen`) USING BTREE;

--
-- Indexes for table `jurusan`
--
ALTER TABLE `jurusan`
  ADD PRIMARY KEY (`id_jurusan`) USING BTREE;

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`NPM`) USING BTREE,
  ADD KEY `id_prodi` (`id_prodi`) USING BTREE;

--
-- Indexes for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  ADD PRIMARY KEY (`id_matkul`) USING BTREE;

--
-- Indexes for table `nilai_nilai`
--
ALTER TABLE `nilai_nilai`
  ADD PRIMARY KEY (`id_nilai`) USING BTREE,
  ADD KEY `id_dosen` (`id_dosen`) USING BTREE,
  ADD KEY `id_matkul` (`id_matkul`) USING BTREE,
  ADD KEY `NPM` (`NPM`) USING BTREE;

--
-- Indexes for table `prodi`
--
ALTER TABLE `prodi`
  ADD PRIMARY KEY (`id_prodi`) USING BTREE,
  ADD KEY `id_jurusan` (`id_jurusan`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_nilai`
--
ALTER TABLE `detail_nilai`
  MODIFY `id_detail` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `nilai_nilai`
--
ALTER TABLE `nilai_nilai`
  MODIFY `id_nilai` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_nilai`
--
ALTER TABLE `detail_nilai`
  ADD CONSTRAINT `id_nilai` FOREIGN KEY (`id_nilai`) REFERENCES `nilai_nilai` (`id_nilai`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD CONSTRAINT `id_prodi` FOREIGN KEY (`id_prodi`) REFERENCES `prodi` (`id_prodi`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `nilai_nilai`
--
ALTER TABLE `nilai_nilai`
  ADD CONSTRAINT `id_dosen` FOREIGN KEY (`id_dosen`) REFERENCES `dosen` (`id_dosen`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `id_matkul` FOREIGN KEY (`id_matkul`) REFERENCES `mata_kuliah` (`id_matkul`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `NPM` FOREIGN KEY (`NPM`) REFERENCES `mahasiswa` (`NPM`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prodi`
--
ALTER TABLE `prodi`
  ADD CONSTRAINT `id_jurusan` FOREIGN KEY (`id_jurusan`) REFERENCES `jurusan` (`id_jurusan`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
