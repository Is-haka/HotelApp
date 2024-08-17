-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 17, 2024 at 12:27 PM
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
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
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

INSERT INTO `booking` (`id`, `book_no`, `bk_status`, `firstname`, `lastname`, `email`, `room`, `duration`, `region_id`, `hotel_id`, `start_date`, `end_date`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(68, 'BK1102', 1, 'is-haka', 'mbarouk', 'ishaka.mbarouk@gmail.com', 1, 6, 1, 1, '2024-08-23 21:00:00', '2024-08-29 21:00:00', 1, '2024-08-16 20:31:32', '2024-08-16 20:31:32', NULL),
(69, 'BK805', 1, 'is-haka', 'hamad', 'ishaka.hamad@gmail.com', 2, 7, 1, 1, '2024-08-23 21:00:00', '2024-08-30 21:00:00', 1, '2024-08-16 20:32:31', '2024-08-16 20:32:31', NULL),
(70, 'BK2166', 1, 'ishaka', 'mbarouk', 'ishaka.hamad@mail.com', 2, 6, 1, 1, '2024-08-16 21:00:00', '2024-08-22 21:00:00', 1, '2024-08-16 20:35:44', '2024-08-16 20:35:44', NULL),
(71, 'BK1817', 1, 'asasa', 'hdhdhd', 'asa@ma.com', 2, 7, 1, 1, '2024-08-23 21:00:00', '2024-08-30 21:00:00', 1, '2024-08-16 20:38:57', '2024-08-16 20:38:57', NULL),
(72, 'BK8795', 1, 'arar', 'adadda', 'asdaad@adas', 2, 12, 1, 1, '2024-08-16 21:00:00', '2024-08-28 21:00:00', 1, '2024-08-17 00:42:47', '2024-08-17 00:42:47', NULL),
(73, 'BK3115', 1, 'herer', 'ererer', 'erere@erer', 2, 5, 1, 1, '2024-08-16 21:00:00', '2024-08-21 21:00:00', 1, '2024-08-17 00:52:52', '2024-08-17 00:52:52', NULL),
(74, 'BK1083', 1, 'asadsa', 'asdasd', 'asdad@adasds', 2, 2, 1, 1, '2024-08-20 21:00:00', '2024-08-22 21:00:00', 1, '2024-08-17 01:12:15', '2024-08-17 01:12:15', NULL),
(75, 'BK980', 1, 'aruus', 'asas', 'asdja@saa', 2, 18, 1, 1, '2024-08-30 21:00:00', '2024-09-17 21:00:00', 1, '2024-08-17 01:24:36', '2024-08-17 01:24:36', NULL),
(76, 'BK3914', 1, 'asdafa', 'dsasdas', 'asdad@asdada', 1, 6, 1, 1, '2024-08-23 21:00:00', '2024-08-29 21:00:00', 1, '2024-08-17 05:04:34', '2024-08-17 05:04:34', NULL),
(77, 'BK256', 1, 'adfasda', 'hahaha', 'hahah@aaha.com', 2, 7, 1, 1, '2024-08-23 21:00:00', '2024-08-30 21:00:00', 1, '2024-08-17 07:36:03', '2024-08-17 07:36:03', NULL),
(78, 'BK9048', 1, 'asdasdsa', 'asdasda', 'asdsad@asdas', 4, 8, 1, 2, '2024-08-22 21:00:00', '2024-08-30 21:00:00', 1, '2024-08-17 08:11:08', '2024-08-17 08:11:08', NULL),
(79, 'BK1053', 1, 'qwerty', 'wert', 'ertyu@asd', 4, 6, 1, 2, '2024-08-22 21:00:00', '2024-08-28 21:00:00', 1, '2024-08-17 09:35:42', '2024-08-17 09:35:42', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `complain`
--

CREATE TABLE `complain` (
  `id` int(11) NOT NULL,
  `fullname` varchar(100) DEFAULT 'anonymous',
  `phone` varchar(15) NOT NULL,
  `book_no` int(11) DEFAULT NULL,
  `typeOfcomplain` int(11) DEFAULT NULL,
  `customDesc` varchar(500) NOT NULL,
  `replied` tinyint(1) DEFAULT 0,
  `status` varchar(50) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `complain`
--

INSERT INTO `complain` (`id`, `fullname`, `phone`, `book_no`, `typeOfcomplain`, `customDesc`, `replied`, `status`, `created_at`) VALUES
(1, 'qwertyu', '071234567855', NULL, NULL, 'fsfdfgfgdfd\n', 0, 'pending', '2024-08-17 10:16:03');

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

CREATE TABLE `complaints` (
  `complaint_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `booking_id` varchar(100) DEFAULT NULL,
  `complaint_text` text DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Pending',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `response_text` text DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `complaints`
--

INSERT INTO `complaints` (`complaint_id`, `user_id`, `booking_id`, `complaint_text`, `status`, `created_at`, `updated_at`, `response_text`, `resolved_at`) VALUES
(3, 0, NULL, 'What is Mount Meru location', 'Pending', '2024-08-17 09:51:09', '2024-08-17 06:51:09', NULL, NULL),
(4, 0, NULL, 'asdfadfadsf', 'Pending', '2024-08-17 10:45:35', '2024-08-17 07:45:35', NULL, NULL),
(5, 0, NULL, 'I want to schedule \n', 'Pending', '2024-08-17 10:50:56', '2024-08-17 07:50:56', NULL, NULL),
(6, 0, NULL, 'refunding ', 'Pending', '2024-08-17 11:01:13', '2024-08-17 08:01:13', NULL, NULL),
(7, 0, NULL, 'yes', 'Pending', '2024-08-17 11:02:27', '2024-08-17 08:02:27', NULL, NULL),
(8, 0, NULL, 'No', 'Pending', '2024-08-17 11:03:53', '2024-08-17 08:03:53', NULL, NULL),
(9, 0, NULL, 'No', 'Pending', '2024-08-17 11:03:55', '2024-08-17 08:03:55', NULL, NULL),
(10, 0, NULL, 'can I get offer', 'Pending', '2024-08-17 11:05:09', '2024-08-17 08:05:09', NULL, NULL),
(11, 0, NULL, 'asdasdasdasdas', 'Pending', '2024-08-17 11:13:32', '2024-08-17 08:13:32', NULL, NULL),
(12, 0, NULL, 'asdfasdfasdfasdf', 'Pending', '2024-08-17 11:20:40', '2024-08-17 08:20:40', NULL, NULL),
(13, 0, NULL, 'asdfasdfasdfasdf', 'Pending', '2024-08-17 11:20:46', '2024-08-17 08:20:46', NULL, NULL),
(14, 0, NULL, 'asdsadasdasdasdadasdasdsadasdasdasdasdas\n', 'Pending', '2024-08-17 11:25:16', '2024-08-17 08:25:16', NULL, NULL),
(15, 0, NULL, 'asdasdasdasdasda\n', 'Pending', '2024-08-17 11:27:52', '2024-08-17 08:27:52', NULL, NULL),
(16, 0, NULL, 'jkahsfkjasdhfkasdf\n', 'Pending', '2024-08-17 11:33:51', '2024-08-17 08:33:51', NULL, NULL),
(17, 0, NULL, 'asdasdasdasdasdasd\n', 'Pending', '2024-08-17 12:51:00', '2024-08-17 09:51:00', NULL, NULL);

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
(1, 'Mount Meru Hotel', 1, '10396', '+255718945911'),
(2, 'Kibo Palace Hotel', 1, 'Kibo street', 'kibo.hotel@mail.com'),
(3, 'Mbeya City Hotel', 2, 'City center', 'mbeya.hotel@mail.com');

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
(1, 'arusha', 1, '2024-08-07 07:55:53', '2024-08-07 07:55:53', NULL),
(2, 'mbeya', 2, '2024-08-15 07:50:15', '2024-08-15 07:50:15', NULL);

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
(1, 'arusha', '2024-08-07 07:22:48', '2024-08-07 07:22:48', '2024-08-07 07:22:48'),
(2, 'mbeya', '2024-08-15 07:49:21', '2024-08-15 07:49:21', NULL);

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
(2, 1, 'double', 1, '5000.00', 25),
(3, 2, 'single', 1, '3000.00', 25),
(4, 2, 'double', 1, '4000.00', 25);

-- --------------------------------------------------------

--
-- Table structure for table `typeofcomp`
--

CREATE TABLE `typeofcomp` (
  `id` int(11) NOT NULL,
  `type` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `typeofcomp`
--

INSERT INTO `typeofcomp` (`id`, `type`) VALUES
(1, 'Funding'),
(2, 'Days Extension');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `complain`
--
ALTER TABLE `complain`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `complaint_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `hotel`
--
ALTER TABLE `hotel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `region`
--
ALTER TABLE `region`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `typeofcomp`
--
ALTER TABLE `typeofcomp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  ADD CONSTRAINT `anscomp_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `typeofcomp` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `complain`
--
ALTER TABLE `complain`
  ADD CONSTRAINT `complain_ibfk_1` FOREIGN KEY (`typeOfcomplain`) REFERENCES `typeofcomp` (`id`);

--
-- Constraints for table `hotel`
--
ALTER TABLE `hotel`
  ADD CONSTRAINT `hotel_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `location`
--
ALTER TABLE `location`
  ADD CONSTRAINT `location_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `room_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
