-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 14, 2024 at 03:13 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotel_api`
--

-- --------------------------------------------------------

--
-- Table structure for table `anscomp`
--

CREATE TABLE `anscomp` (
  `id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `answer` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id` int(11) NOT NULL,
  `book_no` varchar(255) NOT NULL,
  `bk_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 means booked',
  `room` int(11) NOT NULL,
  `duration` int(2) NOT NULL,
  `region_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `start_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `end_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`id`, `book_no`, `bk_status`, `room`, `duration`, `region_id`, `hotel_id`, `start_date`, `end_date`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'BK2002', 1, 1, 0, 1, 1, '2024-08-13 21:00:00', '2024-08-15 21:00:00', 1, '2024-08-12 22:11:22', '2024-08-12 22:11:22', NULL),
(2, 'BK878', 1, 1, 0, 1, 1, '2024-08-13 21:00:00', '2024-08-15 21:00:00', 1, '2024-08-12 22:21:02', '2024-08-12 22:21:02', NULL),
(3, 'BK7025', 1, 1, 0, 1, 1, '2024-08-15 21:00:00', '2024-08-16 21:00:00', 1, '2024-08-12 22:28:50', '2024-08-12 22:28:50', NULL),
(6, 'BK7155', 1, 2, 0, 1, 1, '2024-08-21 21:00:00', '2024-08-23 21:00:00', 1, '2024-08-12 22:53:36', '2024-08-12 22:53:36', NULL),
(7, 'BK8541', 1, 2, 0, 1, 1, '2024-08-14 21:00:00', '2024-08-16 21:00:00', 1, '2024-08-13 06:53:10', '2024-08-13 06:53:10', NULL),
(8, 'BK836', 1, 1, 0, 1, 1, '2024-08-12 21:00:00', '2024-08-21 21:00:00', 1, '2024-08-13 10:31:30', '2024-08-13 10:31:30', NULL),
(9, 'BK836', 1, 1, 0, 1, 1, '2024-08-12 21:00:00', '2024-08-21 21:00:00', 1, '2024-08-13 10:31:39', '2024-08-13 10:31:39', NULL),
(10, 'BK5847', 1, 1, 0, 1, 1, '2024-08-12 21:00:00', '2024-08-29 21:00:00', 1, '2024-08-13 10:36:01', '2024-08-13 10:36:01', NULL),
(11, 'BK5000', 1, 1, 0, 1, 1, '2024-08-12 21:00:00', '2024-08-12 21:00:00', 1, '2024-08-13 12:17:51', '2024-08-13 12:17:51', NULL),
(12, 'BK1267', 1, 1, 0, 1, 1, '2024-08-14 21:00:00', '2024-08-29 21:00:00', 1, '2024-08-13 12:34:56', '2024-08-13 12:34:56', NULL),
(13, 'BK4389', 1, 1, 0, 1, 1, '2024-08-12 21:00:00', '2024-08-29 21:00:00', 1, '2024-08-13 12:35:24', '2024-08-13 12:35:24', NULL),
(14, 'BK7800', 1, 2, 0, 1, 1, '2024-08-12 21:00:00', '2024-08-22 21:00:00', 1, '2024-08-13 12:58:16', '2024-08-13 12:58:16', NULL),
(15, 'BK4853', 1, 1, 16, 1, 1, '2024-08-12 21:00:00', '2024-08-28 21:00:00', 1, '2024-08-13 13:06:55', '2024-08-13 13:06:55', NULL),
(16, 'BK5941', 1, 1, 2, 1, 1, '2024-08-12 21:00:00', '2024-08-14 21:00:00', 1, '2024-08-13 13:20:32', '2024-08-13 13:20:32', NULL),
(17, 'BK3416', 1, 1, 2, 1, 1, '2024-08-12 21:00:00', '2024-08-14 21:00:00', 1, '2024-08-13 15:16:33', '2024-08-13 15:16:33', NULL),
(19, 'BK9695', 1, 1, 3, 1, 1, '2024-08-13 21:00:00', '2024-08-16 21:00:00', 1, '2024-08-14 03:39:44', '2024-08-14 03:39:44', NULL),
(20, 'BK9271', 1, 1, 2, 1, 1, '2024-08-13 21:00:00', '2024-08-15 21:00:00', 1, '2024-08-14 04:13:31', '2024-08-14 04:13:31', NULL),
(21, 'BK6942', 1, 2, 3, 1, 1, '2024-08-13 21:00:00', '2024-08-16 21:00:00', 1, '2024-08-14 05:08:22', '2024-08-14 05:08:22', NULL),
(22, 'BK8265', 1, 1, 3, 1, 1, '2024-08-13 21:00:00', '2024-08-16 21:00:00', 1, '2024-08-14 06:51:53', '2024-08-14 06:51:53', NULL),
(23, 'BK2724', 1, 1, 3, 1, 1, '2024-08-13 21:00:00', '2024-08-16 21:00:00', 1, '2024-08-14 07:33:08', '2024-08-14 07:33:08', NULL),
(24, 'BK6979', 1, 1, 3, 1, 1, '2024-08-13 21:00:00', '2024-08-16 21:00:00', 1, '2024-08-14 07:37:37', '2024-08-14 07:37:37', NULL),
(25, 'BK3912', 1, 1, 3, 1, 1, '2024-08-13 21:00:00', '2024-08-16 21:00:00', 1, '2024-08-14 07:42:51', '2024-08-14 07:42:51', NULL),
(26, 'BK3381', 1, 1, 3, 1, 1, '2024-08-13 21:00:00', '2024-08-16 21:00:00', 1, '2024-08-14 07:43:36', '2024-08-14 07:43:36', NULL),
(28, 'BK1344', 1, 1, 3, 1, 1, '2024-08-13 21:00:00', '2024-08-16 21:00:00', 1, '2024-08-14 07:51:57', '2024-08-14 07:51:57', NULL),
(29, 'BK5820', 1, 0, 7, 1, 1, '2024-09-13 21:00:00', '2024-09-20 21:00:00', 1, '2024-08-14 11:30:41', '2024-08-14 11:30:41', NULL),
(30, 'BK2265', 1, 0, 7, 1, 1, '2024-10-04 21:00:00', '2024-10-11 21:00:00', 1, '2024-08-14 11:31:34', '2024-08-14 11:31:34', NULL),
(31, 'BK317', 1, 0, 17, 1, 1, '2024-08-13 21:00:00', '2024-08-30 21:00:00', 1, '2024-08-14 11:54:42', '2024-08-14 11:54:42', NULL),
(32, 'BK6984', 1, 0, 17, 1, 1, '2024-08-13 21:00:00', '2024-08-30 21:00:00', 1, '2024-08-14 12:05:15', '2024-08-14 12:05:15', NULL),
(33, 'BK2363', 1, 0, 17, 1, 1, '2024-08-13 21:00:00', '2024-08-30 21:00:00', 1, '2024-08-14 12:06:30', '2024-08-14 12:06:30', NULL),
(34, 'BK2784', 1, 0, 24, 1, 1, '2024-08-13 21:00:00', '2024-09-06 21:00:00', 1, '2024-08-14 12:23:19', '2024-08-14 12:23:19', NULL),
(35, 'BK1700', 1, 0, 17, 1, 1, '2024-08-13 21:00:00', '2024-08-30 21:00:00', 1, '2024-08-14 12:25:35', '2024-08-14 12:25:35', NULL),
(36, 'BK4708', 1, 1, 24, 1, 1, '2024-08-13 21:00:00', '2024-09-06 21:00:00', 1, '2024-08-14 12:27:42', '2024-08-14 12:27:42', NULL),
(37, 'BK7710', 1, 1, 17, 1, 1, '2024-08-13 21:00:00', '2024-08-30 21:00:00', 1, '2024-08-14 12:28:27', '2024-08-14 12:28:27', NULL),
(38, 'BK2427', 1, 1, 23, 1, 1, '2024-08-13 21:00:00', '2024-09-05 21:00:00', 1, '2024-08-14 12:29:14', '2024-08-14 12:29:14', NULL),
(39, 'BK6816', 1, 1, 24, 1, 1, '2024-08-13 21:00:00', '2024-09-06 21:00:00', 1, '2024-08-14 12:37:53', '2024-08-14 12:37:53', NULL),
(40, 'BK9557', 1, 1, 13, 1, 1, '2024-08-15 21:00:00', '2024-08-28 21:00:00', 1, '2024-08-14 12:48:00', '2024-08-14 12:48:00', NULL),
(41, 'BK1961', 1, 2, 0, 1, 1, '2024-08-13 21:00:00', '2024-08-13 21:00:00', 1, '2024-08-14 13:04:24', '2024-08-14 13:04:24', NULL),
(42, 'BK511', 1, 2, 1, 1, 1, '2024-08-13 21:00:00', '2024-08-14 21:00:00', 1, '2024-08-14 13:05:34', '2024-08-14 13:05:34', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `complain`
--

CREATE TABLE `complain` (
  `id` int(11) NOT NULL,
  `book_no` int(11) DEFAULT NULL,
  `typeOfcomplain` int(11) DEFAULT NULL,
  `customDesc` varchar(500) NOT NULL,
  `replied` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

CREATE TABLE `complaints` (
  `complaint_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `booking_id` int(11) DEFAULT NULL,
  `hotel_id` int(11) DEFAULT NULL,
  `complaint_text` text NOT NULL,
  `status` varchar(50) DEFAULT 'Pending',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `response_text` text DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hotel`
--

CREATE TABLE `hotel` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `region_id` int(11) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `contact_info` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `hotel`
--

INSERT INTO `hotel` (`id`, `name`, `region_id`, `address`, `contact_info`) VALUES
(1, 'Mount Meru Hotel', 1, '10396', '+255718945911');

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `region_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`id`, `name`, `region_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Arusha', 1, '2024-08-07 07:55:53', '2024-08-07 07:55:53', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `region`
--

CREATE TABLE `region` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `region`
--

INSERT INTO `region` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'arusha', '2024-08-07 07:22:48', '2024-08-07 07:22:48', '2024-08-07 07:22:48');

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `type` enum('single','double') NOT NULL,
  `is_available` tinyint(1) DEFAULT 1,
  `price` decimal(10,2) NOT NULL,
  `total_rooms` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`id`, `hotel_id`, `type`, `is_available`, `price`, `total_rooms`) VALUES
(1, 1, 'single', 1, '2000.00', 25),
(2, 1, 'double', 1, '5000.00', 25);

-- --------------------------------------------------------

--
-- Table structure for table `typeofcomp`
--

CREATE TABLE `typeofcomp` (
  `id` int(11) NOT NULL,
  `type` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `role` varchar(50) DEFAULT 'customer',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `email`, `full_name`, `phone_number`, `role`, `created_at`, `updated_at`) VALUES
(1, 'fabio@gmail.com', 'fabio', '+255718945911', 'customer', '2024-08-12 21:52:24', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `anscomp`
--
ALTER TABLE `anscomp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type_id` (`type_id`);

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `region_id` (`region_id`),
  ADD KEY `hotel_id` (`hotel_id`),
  ADD KEY `room` (`room`);

--
-- Indexes for table `complain`
--
ALTER TABLE `complain`
  ADD PRIMARY KEY (`id`),
  ADD KEY `typeOfcomplain` (`typeOfcomplain`);

--
-- Indexes for table `complaints`
--
ALTER TABLE `complaints`
  ADD PRIMARY KEY (`complaint_id`),
  ADD KEY `booking_id` (`booking_id`),
  ADD KEY `hotel_id` (`hotel_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `hotel`
--
ALTER TABLE `hotel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `region_id` (`region_id`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`id`),
  ADD KEY `region_id` (`region_id`);

--
-- Indexes for table `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hotel_id` (`hotel_id`);

--
-- Indexes for table `typeofcomp`
--
ALTER TABLE `typeofcomp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `anscomp`
--
ALTER TABLE `anscomp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `complain`
--
ALTER TABLE `complain`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `complaint_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hotel`
--
ALTER TABLE `hotel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `region`
--
ALTER TABLE `region`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `typeofcomp`
--
ALTER TABLE `typeofcomp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `anscomp`
--
ALTER TABLE `anscomp`
  ADD CONSTRAINT `anscomp_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `typeofcomp` (`id`);

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`),
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`id`),
  ADD CONSTRAINT `room` FOREIGN KEY (`room`) REFERENCES `room` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `complain`
--
ALTER TABLE `complain`
  ADD CONSTRAINT `complain_ibfk_1` FOREIGN KEY (`typeOfcomplain`) REFERENCES `typeofcomp` (`id`);

--
-- Constraints for table `complaints`
--
ALTER TABLE `complaints`
  ADD CONSTRAINT `complaints_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`),
  ADD CONSTRAINT `complaints_ibfk_2` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`id`),
  ADD CONSTRAINT `complaints_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `hotel`
--
ALTER TABLE `hotel`
  ADD CONSTRAINT `hotel_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`);

--
-- Constraints for table `location`
--
ALTER TABLE `location`
  ADD CONSTRAINT `location_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`);

--
-- Constraints for table `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `room_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
