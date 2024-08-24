-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 24, 2024 at 01:26 PM
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
  `answer` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `anscomp`
--

INSERT INTO `anscomp` (`id`, `type_id`, `answer`) VALUES
(1, 1, 'Thank you for reaching out regarding your refund request. Based on our policy, refunds are processed within 7-10 business days from the date of the request. If your booking is eligible for a refund, the amount will be credited back to the original payment method used during the booking. Please ensure that all necessary documents and information are provided to avoid delays. If you have any further questions or need additional assistance, feel free to ask.\r\n'),
(2, 2, 'We understand that you would like to extend your stay. To extend the number of days for your current booking, please note that this will depend on the availability of rooms. If available, the additional cost will be calculated based on the current rates and any applicable discounts. We recommend contacting our support team as soon as possible to confirm the extension. If you need further assistance or have additional questions, please let us know.\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `ansinquiry`
--

CREATE TABLE `ansinquiry` (
  `id` int(11) NOT NULL,
  `answer` varchar(255) NOT NULL,
  `inquirytype_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ansinquiry`
--

INSERT INTO `ansinquiry` (`id`, `answer`, `inquirytype_id`) VALUES
(1, 'To book, simply use this portal by click on booking then select your desired package, and follow the easy checkout process.', 1),
(2, 'Yes, we offer seasonal discounts and special rates for group bookings. Please use this portal and select the booking option at the very first of this conversation.', 2),
(3, 'You can reach us by flying into the nearest airport, where we provide a complimentary transfer to our location. Detailed directions will be provided in your booking confirmation.', 3);

-- --------------------------------------------------------

--
-- Table structure for table `ans_related_complain`
--

CREATE TABLE `ans_related_complain` (
  `id` int(11) NOT NULL,
  `answer_complain` varchar(2000) NOT NULL,
  `related_c_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ans_related_complain`
--

INSERT INTO `ans_related_complain` (`id`, `answer_complain`, `related_c_id`) VALUES
(1, 'We understand your concern. The cost of extending a stay is based on room availability and rates. Please contact our reservations team to discuss options and pricing.', 3),
(2, 'We apologize for any confusion. Refund amounts depend on the cancellation policy and timing. Share your booking details with us, and we’ll clarify the amount', 1),
(3, 'We’re sorry to hear that you’re dissatisfied. Full refunds are processed according to our policy. Please provide your booking information, and we’ll review your request as soon as possible.', 2),
(4, 'We apologize for the delay. Extensions are typically processed within a few hours, depending on room availability. Please reach out to the front desk or reservations team for quicker assistance.', 4);

-- --------------------------------------------------------

--
-- Table structure for table `ans_related_inquiry`
--

CREATE TABLE `ans_related_inquiry` (
  `id` int(11) NOT NULL,
  `answer_inquiry` varchar(2000) NOT NULL,
  `related_i_id` int(11) DEFAULT NULL
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
(79, 'BK1053', 1, 'qwerty', 'wert', 'ertyu@asd', 4, 6, 1, 2, '2024-08-22 21:00:00', '2024-08-28 21:00:00', 1, '2024-08-17 09:35:42', '2024-08-17 09:35:42', NULL),
(80, 'BK3769', 1, 'ishaka', 'mbarouk', 'ishaqa@gmail.com', 4, 4, 1, 2, '2024-08-16 21:00:00', '2024-08-20 21:00:00', 1, '2024-08-17 14:36:24', '2024-08-17 14:36:24', NULL),
(81, 'BK4389', 1, 'ishak', 'hamad', 'mbarouk@gmail.com', 3, 27, 1, 2, '2024-08-30 21:00:00', '2024-09-26 21:00:00', 1, '2024-08-18 07:21:39', '2024-08-18 07:21:39', NULL),
(82, 'BK1734', 1, 'aaaa', 'aaaa', 'aa@aa.aa', 2, 14, 1, 1, '2024-08-22 21:00:00', '2024-09-05 21:00:00', 1, '2024-08-23 07:22:59', '2024-08-23 07:22:59', NULL),
(83, 'BK5086', 1, 'ggggggggggggg', 'ffffffffff', 'aa@a.c', 2, 5, 1, 1, '2024-08-23 21:00:00', '2024-08-28 21:00:00', 1, '2024-08-24 01:57:49', '2024-08-24 01:57:49', NULL),
(84, 'BK8664', 1, 'Ishak', 'Mbarouk', 'ishak.mbarouk@me.com', 4, 4, 1, 2, '2024-08-23 21:00:00', '2024-08-27 21:00:00', 1, '2024-08-24 11:14:38', '2024-08-24 11:14:38', NULL),
(85, 'BK851', 1, 'Ishak', 'Mbarouk', 'im@gmail.com', 4, 2, 1, 2, '2024-08-23 21:00:00', '2024-08-25 21:00:00', 1, '2024-08-24 11:26:06', '2024-08-24 11:26:06', NULL);

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
  `typeOfInquiry` int(11) DEFAULT NULL,
  `customDesc` varchar(500) DEFAULT NULL,
  `replied` tinyint(1) DEFAULT 0,
  `status` varchar(50) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `complain`
--

INSERT INTO `complain` (`id`, `fullname`, `phone`, `book_no`, `typeOfcomplain`, `typeOfInquiry`, `customDesc`, `replied`, `status`, `created_at`) VALUES
(1, 'qwertyu', '071234567855', NULL, NULL, 1, 'fsfdfgfgdfd\n', 0, 'pending', '2024-08-17 10:16:03'),
(2, 'asaas', '0876675765765', NULL, NULL, 1, 'dasddsadadad\n', 0, 'pending', '2024-08-18 07:23:46'),
(3, 'iska', '0756123111111', NULL, NULL, 1, 'adsadadasdsadasasdasdasdsadasdasdasd', 0, 'pending', '2024-08-23 14:37:13'),
(4, 'customDesc', 'customDesccusto', NULL, NULL, NULL, 'customDesc', 0, 'pending', '2024-08-24 04:11:50'),
(5, 'customDesc', 'customDesccusto', NULL, NULL, NULL, 'customDesc', 0, 'pending', '2024-08-24 04:13:33'),
(6, 'text-center text-md-start', 'text-center tex', NULL, NULL, NULL, 'text-center text-md-start\n', 0, 'pending', '2024-08-24 04:21:22'),
(7, 'p-2 rounded bg-light text-dark', 'p-2 rounded bg-', NULL, NULL, NULL, 'p-2 rounded bg-light text-dark', 0, 'pending', '2024-08-24 04:31:46'),
(8, 'typeOfInquiry', 'typeOfInquiry', NULL, NULL, 1, 'typeOfInquiry', 0, 'pending', '2024-08-24 04:35:59'),
(9, 'typeOfInquiry', 'typeOfInquiry', NULL, NULL, 3, 'Second for id 2', 0, 'pending', '2024-08-24 04:36:32'),
(10, 'typeOfInquiry', '0712345678934', NULL, NULL, 2, 'group bookings. ', 0, 'pending', '2024-08-24 04:39:43'),
(11, 'Is-haka', '0715641114', NULL, NULL, 2, 'How about from 50,000 TZS', 0, 'pending', '2024-08-24 04:45:35'),
(12, 'Ishak', '0715641114', NULL, NULL, 3, 'hello there how are you doing today, thanks for the reply', 0, 'pending', '2024-08-24 10:52:49'),
(13, 'Ishak', '0715641114', NULL, NULL, 2, 'Thank you so much', 0, 'pending', '2024-08-24 11:02:44'),
(14, 'Ishak', '0715641114', NULL, NULL, 3, 'Hello there', 0, 'pending', '2024-08-24 11:06:27'),
(15, 'Ishak', '0715641114', NULL, NULL, 3, 'Hello there', 0, 'pending', '2024-08-24 11:08:03');

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
-- Table structure for table `related_complain`
--

CREATE TABLE `related_complain` (
  `id` int(11) NOT NULL,
  `related_complain` varchar(255) NOT NULL,
  `type_c_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `related_complain`
--

INSERT INTO `related_complain` (`id`, `related_complain`, `type_c_id`) VALUES
(1, 'The refund process is so confusing! I don\'t even know how much I\'ll get back.', 1),
(2, 'I’m really disappointed with the service and want a full refund', 1),
(3, 'Extending my stay shouldn’t be so costly! It feels like I\'m being overcharged.', 2),
(4, 'Why does it take so long to extend my stay? This process is too slow!', 2);

-- --------------------------------------------------------

--
-- Table structure for table `related_inquiry`
--

CREATE TABLE `related_inquiry` (
  `id` int(11) NOT NULL,
  `related_inquiry` varchar(2000) NOT NULL,
  `type_i_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
(1, 'Refunding'),
(2, 'Days Extension');

-- --------------------------------------------------------

--
-- Table structure for table `typeofinquiry`
--

CREATE TABLE `typeofinquiry` (
  `id` int(11) NOT NULL,
  `inquiry` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `typeofinquiry`
--

INSERT INTO `typeofinquiry` (`id`, `inquiry`) VALUES
(1, 'How to book?'),
(2, 'Are there discounts?'),
(3, 'How to get there?');

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
-- Indexes for table `ansinquiry`
--
ALTER TABLE `ansinquiry`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inquirytype_id` (`inquirytype_id`);

--
-- Indexes for table `ans_related_complain`
--
ALTER TABLE `ans_related_complain`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ans_related_complain_ibfk_1` (`related_c_id`);

--
-- Indexes for table `ans_related_inquiry`
--
ALTER TABLE `ans_related_inquiry`
  ADD PRIMARY KEY (`id`),
  ADD KEY `related_i_id` (`related_i_id`);

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
  ADD KEY `typeOfcomplain` (`typeOfcomplain`),
  ADD KEY `fk_typeOfInquiry` (`typeOfInquiry`);

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
-- Indexes for table `related_complain`
--
ALTER TABLE `related_complain`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type_id` (`type_c_id`);

--
-- Indexes for table `related_inquiry`
--
ALTER TABLE `related_inquiry`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type_i_id` (`type_i_id`);

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
-- Indexes for table `typeofinquiry`
--
ALTER TABLE `typeofinquiry`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ansinquiry`
--
ALTER TABLE `ansinquiry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ans_related_complain`
--
ALTER TABLE `ans_related_complain`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ans_related_inquiry`
--
ALTER TABLE `ans_related_inquiry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `complain`
--
ALTER TABLE `complain`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
-- AUTO_INCREMENT for table `related_complain`
--
ALTER TABLE `related_complain`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `related_inquiry`
--
ALTER TABLE `related_inquiry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT for table `typeofinquiry`
--
ALTER TABLE `typeofinquiry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
-- Constraints for table `ansinquiry`
--
ALTER TABLE `ansinquiry`
  ADD CONSTRAINT `ansinquiry_ibfk_1` FOREIGN KEY (`inquirytype_id`) REFERENCES `typeofinquiry` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `ans_related_complain`
--
ALTER TABLE `ans_related_complain`
  ADD CONSTRAINT `ans_related_complain_ibfk_1` FOREIGN KEY (`related_c_id`) REFERENCES `related_complain` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ans_related_inquiry`
--
ALTER TABLE `ans_related_inquiry`
  ADD CONSTRAINT `ans_related_inquiry_ibfk_1` FOREIGN KEY (`related_i_id`) REFERENCES `related_inquiry` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `complain`
--
ALTER TABLE `complain`
  ADD CONSTRAINT `complain_ibfk_1` FOREIGN KEY (`typeOfcomplain`) REFERENCES `typeofcomp` (`id`),
  ADD CONSTRAINT `fk_typeOfInquiry` FOREIGN KEY (`typeOfInquiry`) REFERENCES `typeofinquiry` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

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
-- Constraints for table `related_complain`
--
ALTER TABLE `related_complain`
  ADD CONSTRAINT `related_complain_ibfk_1` FOREIGN KEY (`type_c_id`) REFERENCES `typeofcomp` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `related_inquiry`
--
ALTER TABLE `related_inquiry`
  ADD CONSTRAINT `related_inquiry_ibfk_1` FOREIGN KEY (`type_i_id`) REFERENCES `typeofinquiry` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `room_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
