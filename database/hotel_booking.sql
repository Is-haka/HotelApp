-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Aug 25, 2024 at 01:32 AM
-- Server version: 8.0.31
-- PHP Version: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotel_booking`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
CREATE TABLE IF NOT EXISTS `bookings` (
  `Booking_ID` int NOT NULL AUTO_INCREMENT,
  `Customer_ID` int NOT NULL,
  `Room_ID` int NOT NULL,
  `Hotel_ID` int NOT NULL,
  `Check_In_Date` date NOT NULL,
  `Check_Out_Date` date NOT NULL,
  `Booking_Status` enum('Confirmed','Cancelled','Completed') COLLATE utf8mb4_general_ci DEFAULT 'Confirmed',
  `Booking_Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Total_Amount` decimal(10,2) NOT NULL,
  `Number_of_Rooms` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Number_of_Adults` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Number_of_Children` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`Booking_ID`),
  KEY `Customer_ID` (`Customer_ID`),
  KEY `Room_ID` (`Room_ID`),
  KEY `Hotel_ID` (`Hotel_ID`),
  KEY `idx_bookings_hotel_id` (`Hotel_ID`),
  KEY `idx_bookings_customer_id` (`Customer_ID`),
  KEY `idx_bookings_room_id` (`Room_ID`),
  KEY `Check_In_Date_idx` (`Check_In_Date`),
  KEY `Check_Out_Date_idx` (`Check_Out_Date`),
  KEY `Booking_Status_idx` (`Booking_Status`),
  KEY `bok_total_amount` (`Total_Amount`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`Booking_ID`, `Customer_ID`, `Room_ID`, `Hotel_ID`, `Check_In_Date`, `Check_Out_Date`, `Booking_Status`, `Booking_Date`, `Total_Amount`, `Number_of_Rooms`, `Number_of_Adults`, `Number_of_Children`) VALUES
(91, 64, 33, 14, '2024-08-04', '2024-08-06', 'Completed', '2024-08-01 12:33:37', '9100000.00', '1', '1', '0'),
(92, 55, 33, 16, '2024-08-24', '2024-08-31', 'Cancelled', '2025-08-20 15:02:45', '76000.00', '2', '1', '1'),
(93, 1, 33, 16, '2024-08-22', '2024-08-29', 'Cancelled', '2024-08-21 21:43:01', '76000.00', '98', '9', '9'),
(94, 1, 33, 16, '2024-08-30', '2024-08-31', 'Cancelled', '2024-08-21 21:44:08', '100000.00', '7', '3', '1');

-- --------------------------------------------------------

--
-- Table structure for table `booking_arrival`
--

DROP TABLE IF EXISTS `booking_arrival`;
CREATE TABLE IF NOT EXISTS `booking_arrival` (
  `bk_ar_id` int NOT NULL AUTO_INCREMENT,
  `Booking_ID` int DEFAULT NULL,
  `arrival_id` int DEFAULT NULL,
  PRIMARY KEY (`bk_ar_id`),
  KEY `arrival_ID` (`arrival_id`),
  KEY `booking_arrival_ibfk_2` (`Booking_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `booking_arrival`
--

INSERT INTO `booking_arrival` (`bk_ar_id`, `Booking_ID`, `arrival_id`) VALUES
(9, 91, 49);

-- --------------------------------------------------------

--
-- Table structure for table `booking_promotions`
--

DROP TABLE IF EXISTS `booking_promotions`;
CREATE TABLE IF NOT EXISTS `booking_promotions` (
  `Booking_ID` int NOT NULL,
  `Promotion_ID` int NOT NULL,
  PRIMARY KEY (`Booking_ID`,`Promotion_ID`),
  KEY `Promotion_ID` (`Promotion_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `booking_services`
--

DROP TABLE IF EXISTS `booking_services`;
CREATE TABLE IF NOT EXISTS `booking_services` (
  `Booking_Service_ID` int NOT NULL AUTO_INCREMENT,
  `Booking_ID` int NOT NULL,
  `Service_ID` int NOT NULL,
  `Total_Amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`Booking_Service_ID`),
  KEY `Booking_ID` (`Booking_ID`),
  KEY `Service_ID` (`Service_ID`),
  KEY `Total_Amount_idx` (`Total_Amount`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

DROP TABLE IF EXISTS `complaints`;
CREATE TABLE IF NOT EXISTS `complaints` (
  `Complaint_ID` int NOT NULL AUTO_INCREMENT,
  `Booking_ID` int NOT NULL,
  `Customer_ID` int NOT NULL,
  `Complaint_Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Complaint_Details` text COLLATE utf8mb4_general_ci,
  `Status` enum('Open','In Progress','Closed') COLLATE utf8mb4_general_ci DEFAULT 'Open',
  PRIMARY KEY (`Complaint_ID`),
  KEY `Booking_ID` (`Booking_ID`),
  KEY `Customer_ID` (`Customer_ID`),
  KEY `Complaint_Date_idx` (`Complaint_Date`),
  KEY `Status_comp_idx` (`Status`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `Customer_ID` int NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Last_Name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `Phone` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `City` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `activation_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'inactive',
  `Password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`Customer_ID`),
  UNIQUE KEY `Email` (`Email`),
  KEY `idx_customers_customer_id` (`Customer_ID`),
  KEY `idx_customers_email` (`Email`),
  KEY `cust_pass_idx` (`Password`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`Customer_ID`, `First_Name`, `Last_Name`, `Email`, `Phone`, `City`, `activation_status`, `Password`) VALUES
(1, 'moses', 'Ndambaro', 'mose@gmail.com', '0755605020', 'Kigoma', 'activated', '$2b$12$ptZODg7GcFNJOUhyDahTueyY6hfxrlOo0bUfzPLdh64Vnomm1qGAC'),
(55, 'Maria', 'Chacha', 'maria@yahoo.com', '0789456790', NULL, 'activated', '$2b$12$lyg3l1M816AV46kJx88.4uzl4MQAbgPMEYrh1mphFW8ABtiF3ho7S'),
(64, 'raphael', 'kilimbo', 'raphaelmgonja47@gmail.com', '0789456790', 'Kigoma', 'activated', '$2b$12$CG3ERHfA1eX2MHIkxPUWX.Sv2THSVvww.yswe2AqtKJlHS/fNpgma');

-- --------------------------------------------------------

--
-- Table structure for table `customer_arrival`
--

DROP TABLE IF EXISTS `customer_arrival`;
CREATE TABLE IF NOT EXISTS `customer_arrival` (
  `arrival_id` int NOT NULL AUTO_INCREMENT,
  `arrival_time` varchar(20) NOT NULL,
  `guest` varchar(100) NOT NULL,
  `Booking_ID` int DEFAULT NULL,
  `customer_id` int NOT NULL,
  `hotel_ID` int NOT NULL,
  PRIMARY KEY (`arrival_id`),
  KEY `customer_id` (`customer_id`),
  KEY `hotel_ID` (`hotel_ID`),
  KEY `Booking_ID` (`Booking_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `customer_arrival`
--

INSERT INTO `customer_arrival` (`arrival_id`, `arrival_time`, `guest`, `Booking_ID`, `customer_id`, `hotel_ID`) VALUES
(49, '15:36', 'I am the main guest', NULL, 1, 14);

--
-- Triggers `customer_arrival`
--
DROP TRIGGER IF EXISTS `after_table2_insert`;
DELIMITER $$
CREATE TRIGGER `after_table2_insert` AFTER INSERT ON `customer_arrival` FOR EACH ROW BEGIN
    DECLARE temp_booking_id INT;

    -- Fetch the Booking_ID from bookings based on the Customer_ID
    SELECT Booking_ID INTO temp_booking_id
    FROM bookings
    WHERE Customer_ID = NEW.Customer_ID
    ORDER BY Booking_ID DESC
    LIMIT 1;

    -- Insert into booking_arrival using fetched Booking_ID and new arrival_id
    INSERT INTO booking_arrival (Booking_ID, arrival_id)
    VALUES (temp_booking_id, NEW.arrival_id);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `hotels`
--

DROP TABLE IF EXISTS `hotels`;
CREATE TABLE IF NOT EXISTS `hotels` (
  `Hotel_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `Address` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `City` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `Country` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `ZipCode` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `Phone` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Website` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`Hotel_ID`),
  KEY `user_id` (`user_id`),
  KEY `idx_hotels_hotel_id` (`Hotel_ID`),
  KEY `Hotel_nameIDX` (`Name`),
  KEY `Address_idx` (`City`),
  KEY `Country_IDX` (`Country`),
  KEY `ZipCode_idx` (`ZipCode`),
  KEY `Phone_IDX` (`Phone`),
  KEY `Email_IDX` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotels`
--

INSERT INTO `hotels` (`Hotel_ID`, `Name`, `Address`, `City`, `Country`, `ZipCode`, `Phone`, `Email`, `Website`, `user_id`) VALUES
(14, 'Gran Melia', 'kilombero street', 'Arusha', 'Tanzania', 'LAB 45', '0742985328', 'granmelia@yahoo.com', 'wwwgranmeliacom', 42),
(15, 'Ngurdoto', 'BOX 645 Arusha', 'Dodoma', 'Tanzania', 'mec 355', '0742985328', 'ngurdoto@gmail.com', 'wwwngurdotocom', 42),
(16, 'Tulia hotel', 'kibo street', 'Arusha', 'Tanzania', 'pr4553', '0747294994', 'tulia@gmail.com', 'tuliasomeyahoocom', 42);

-- --------------------------------------------------------

--
-- Table structure for table `hotel_images`
--

DROP TABLE IF EXISTS `hotel_images`;
CREATE TABLE IF NOT EXISTS `hotel_images` (
  `Image_ID` int NOT NULL AUTO_INCREMENT,
  `Hotel_ID` int NOT NULL,
  `Image_URL` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`Image_ID`),
  KEY `Hotel_ID` (`Hotel_ID`),
  KEY `hotel_images_url_idx` (`Image_URL`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotel_images`
--

INSERT INTO `hotel_images` (`Image_ID`, `Hotel_ID`, `Image_URL`) VALUES
(45, 16, 'hotel_images\\hhone.jpg'),
(46, 14, 'hotel_images\\hhtwo.jpg'),
(47, 15, 'hotel_images\\hhthree.jpg'),
(53, 14, 'hotel_images\\3255769.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `map_locations`
--

DROP TABLE IF EXISTS `map_locations`;
CREATE TABLE IF NOT EXISTS `map_locations` (
  `Location_ID` int NOT NULL AUTO_INCREMENT,
  `Hotel_ID` int NOT NULL,
  `Latitude` decimal(9,6) NOT NULL,
  `Longitude` decimal(9,6) NOT NULL,
  PRIMARY KEY (`Location_ID`),
  KEY `Hotel_ID` (`Hotel_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `map_locations`
--

INSERT INTO `map_locations` (`Location_ID`, `Hotel_ID`, `Latitude`, `Longitude`) VALUES
(1, 14, '-34.154758', '150.069598'),
(2, 14, '-34.377961', '150.610675'),
(3, 15, '-34.423285', '150.292071'),
(4, 14, '-34.177636', '150.577716'),
(5, 14, '-34.237299', '150.555743'),
(6, 14, '-34.778980', '149.726275'),
(7, 14, '-33.835199', '150.550250'),
(8, 15, '-34.347731', '151.731280');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `Payment_ID` int NOT NULL AUTO_INCREMENT,
  `Booking_ID` int DEFAULT NULL,
  `Payment_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Amount` decimal(10,2) DEFAULT NULL,
  `payment_provider` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Payment_Status` enum('Pending','Completed','Failed') COLLATE utf8mb4_general_ci DEFAULT 'Pending',
  `merchant_ref` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reference` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `external_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bank_acc_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pay_currency` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_number` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`Payment_ID`),
  KEY `Booking_ID` (`Booking_ID`),
  KEY `pay_amount_idx` (`Amount`),
  KEY `provide_idx` (`payment_provider`),
  KEY `Payment_Status_idx` (`Payment_Status`),
  KEY `merchant_ref_idx` (`merchant_ref`),
  KEY `reference_idx` (`reference`),
  KEY `pay_currency_idx` (`pay_currency`),
  KEY `phone_number_idx` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`Payment_ID`, `Booking_ID`, `Payment_Date`, `Amount`, `payment_provider`, `Payment_Status`, `merchant_ref`, `reference`, `external_id`, `bank_acc_no`, `pay_currency`, `phone_number`) VALUES
(218, 91, '2024-08-15 12:34:08', '9100000.00', 'Airtel', 'Completed', '45b1ec6e3b5548b2a981468a185086f9', '45b1ec6e3b5548b2a981468a185086f9', NULL, NULL, 'TZS', '0786112616'),
(219, 93, '2024-08-21 23:37:04', '76000.00', 'Mpesa', 'Pending', '12cdfhk9222mmdss0', '1299rtry5bbb', NULL, NULL, 'TZS', '1234567');

-- --------------------------------------------------------

--
-- Table structure for table `promotions`
--

DROP TABLE IF EXISTS `promotions`;
CREATE TABLE IF NOT EXISTS `promotions` (
  `Promotion_ID` int NOT NULL AUTO_INCREMENT,
  `Hotel_ID` int NOT NULL,
  `Promotion_Name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `Description` text COLLATE utf8mb4_general_ci,
  `Discount_Percentage` decimal(5,2) NOT NULL,
  `Start_Date` date NOT NULL,
  `End_Date` date NOT NULL,
  PRIMARY KEY (`Promotion_ID`),
  KEY `Hotel_ID` (`Hotel_ID`),
  KEY `Promotion_Name_idx` (`Promotion_Name`),
  KEY `Discount_Percentage_idx` (`Discount_Percentage`),
  KEY `Start_Date_idx` (`Start_Date`),
  KEY `End_Date_idx` (`End_Date`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `promotions`
--

INSERT INTO `promotions` (`Promotion_ID`, `Hotel_ID`, `Promotion_Name`, `Description`, `Discount_Percentage`, `Start_Date`, `End_Date`) VALUES
(3, 14, 'swimming pool', 'water circulation', '5.00', '0000-00-00', '0000-00-00'),
(4, 15, 'lunch', 'food discounted', '4.00', '0000-00-00', '0000-00-00'),
(5, 15, 'lunch', 'food discounted', '4.00', '0000-00-00', '0000-00-00'),
(11, 16, 'swimming pool', 'good view of mt meru', '4.00', '0000-00-00', '0000-00-00'),
(16, 16, 'soccer arena', 'can hold up to 7000 people', '7.00', '2024-07-13', '2024-07-13');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE IF NOT EXISTS `reviews` (
  `Review_ID` int NOT NULL AUTO_INCREMENT,
  `Customer_ID` int NOT NULL,
  `Hotel_ID` int NOT NULL,
  `Review_Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Rating` int DEFAULT NULL,
  `Comments` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`Review_ID`),
  KEY `Customer_ID` (`Customer_ID`),
  KEY `Hotel_ID` (`Hotel_ID`)
) ;

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
CREATE TABLE IF NOT EXISTS `rooms` (
  `Room_ID` int NOT NULL AUTO_INCREMENT,
  `Hotel_ID` int NOT NULL,
  `Room_Type_ID` int NOT NULL,
  `Room_Number` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `Status` enum('Available','Booked','Under Maintenance') COLLATE utf8mb4_general_ci DEFAULT 'Available',
  PRIMARY KEY (`Room_ID`),
  KEY `Hotel_ID` (`Hotel_ID`),
  KEY `Room_Type_ID` (`Room_Type_ID`),
  KEY `idx_rooms_room_id` (`Room_ID`),
  KEY `Room_Number` (`Room_Number`),
  KEY `Status_idx` (`Status`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`Room_ID`, `Hotel_ID`, `Room_Type_ID`, `Room_Number`, `Status`) VALUES
(12, 14, 17, '5', 'Available'),
(13, 14, 18, '5', 'Available'),
(14, 15, 20, 'R 5', 'Available'),
(33, 16, 31, 'HG 23', 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `room_images`
--

DROP TABLE IF EXISTS `room_images`;
CREATE TABLE IF NOT EXISTS `room_images` (
  `Image_ID` int NOT NULL AUTO_INCREMENT,
  `Room_ID` int NOT NULL,
  `Image_URL` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`Image_ID`),
  KEY `Room_ID` (`Room_ID`),
  KEY `Image_URL_idx` (`Image_URL`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room_images`
--

INSERT INTO `room_images` (`Image_ID`, `Room_ID`, `Image_URL`) VALUES
(14, 13, 'uploads_rooms_img\\room1.jpg'),
(16, 33, 'uploads_rooms_img\\room_3.jpg'),
(27, 12, 'uploads_rooms_img\\tobias-tullius-2z6TmSRQI64-unsplash.jpg'),
(28, 14, 'uploads_rooms_img\\3255732.jpg'),
(29, 13, 'uploads_rooms_img\\pexels-zhang-kaiyv-1139556.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `room_types`
--

DROP TABLE IF EXISTS `room_types`;
CREATE TABLE IF NOT EXISTS `room_types` (
  `Room_Type_ID` int NOT NULL AUTO_INCREMENT,
  `Hotel_ID` int NOT NULL,
  `Type_Name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `Description` text COLLATE utf8mb4_general_ci,
  `Price` decimal(10,2) NOT NULL,
  `Capacity` int NOT NULL,
  PRIMARY KEY (`Room_Type_ID`),
  KEY `Hotel_ID` (`Hotel_ID`),
  KEY `typenameIdx` (`Type_Name`),
  KEY `CapacityIDX` (`Capacity`),
  KEY `Price_idx` (`Price`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room_types`
--

INSERT INTO `room_types` (`Room_Type_ID`, `Hotel_ID`, `Type_Name`, `Description`, `Price`, `Capacity`) VALUES
(17, 14, 'we', 'single bed with toilet', '13500.00', 13),
(18, 14, 'we', 'video camera visual dj', '134000.00', 13),
(19, 15, 'Single room', 'double bed', '70000.00', 3),
(20, 15, 'extra ', 'for the guest is free and others discounted', '134000.00', 13),
(31, 16, 'junior suite', 'full air conditions', '134000.00', 3),
(32, 14, 'Studio room or apartment', 'full music system', '2000000.00', 8);

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
CREATE TABLE IF NOT EXISTS `services` (
  `Service_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `Price` decimal(10,2) NOT NULL,
  `Duration` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Hotel_ID` int DEFAULT NULL,
  PRIMARY KEY (`Service_ID`),
  KEY `services_ibfk_1` (`Hotel_ID`),
  KEY `service_nameIDX` (`Name`),
  KEY `PriceIDX` (`Price`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`Service_ID`, `Name`, `Description`, `Price`, `Duration`, `Hotel_ID`) VALUES
(25, 'WiFi Access', 'free', '0.00', '24 hrsx7', 14),
(26, 'Parking', 'available for 4X4 car', '0.00', '24 hrsx7', 15),
(28, 'Airport Shuttle', 'take you and return from the airport', '2000000.00', '24 hrsx7', 14),
(29, 'Housekeeping Services', 'free', '100.00', '24 hrsx7', 14);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
CREATE TABLE IF NOT EXISTS `staff` (
  `Staff_ID` int NOT NULL AUTO_INCREMENT,
  `Hotel_ID` int NOT NULL,
  `First_Name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `Last_Name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `Position` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `Phone` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`Staff_ID`),
  KEY `Hotel_ID` (`Hotel_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`Staff_ID`, `Hotel_ID`, `First_Name`, `Last_Name`, `Position`, `Phone`, `Email`) VALUES
(4, 15, 'mohamedi', 'siria', 'Board member', '0742985328', 'mo@gmail.com'),
(5, 14, 'Nasma', 'Idd', 'Manager', '0742985328', 'nasma@gmail.com'),
(7, 15, 'maria', 'shamte', 'Flourist', '0742985390', 'shamte@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `user_accounts`
--

DROP TABLE IF EXISTS `user_accounts`;
CREATE TABLE IF NOT EXISTS `user_accounts` (
  `User_ID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Role` enum('Admin','Customer','Staff') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'Customer',
  `activation_status` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'inactive',
  `Password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `Created_At` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Last_Login` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`User_ID`),
  UNIQUE KEY `Username` (`Username`),
  UNIQUE KEY `Email` (`Email`),
  KEY `emel_idx` (`Email`),
  KEY `Role_idx` (`Role`),
  KEY `Password_idx` (`Password`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_accounts`
--

INSERT INTO `user_accounts` (`User_ID`, `Username`, `Email`, `Role`, `activation_status`, `Password`, `Created_At`, `Last_Login`) VALUES
(42, 'raphael mgonja', 'raphaelmgonja47@gmail.com', 'Admin', 'activated', '$2b$12$JHTJkS77h8RwdSGjf2Iq3eLf9S.J10/c1WbYHxKax3nwIu0g8tHN.', '2024-07-03 19:31:31', '2024-07-03 19:31:31'),
(43, 'mosegmailcom', 'mose@gmail.com', 'Customer', 'activated', '$2b$12$N7jSqP0Nqw37PJnesOpUney7q6d0p18Oo5jgIgym9MYBfRXTZalHy', '2024-07-04 08:11:30', '2024-07-04 08:11:30');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`Customer_ID`) REFERENCES `customers` (`Customer_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`Room_ID`) REFERENCES `rooms` (`Room_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`Hotel_ID`) REFERENCES `hotels` (`Hotel_ID`) ON DELETE CASCADE;

--
-- Constraints for table `booking_arrival`
--
ALTER TABLE `booking_arrival`
  ADD CONSTRAINT `booking_arrival_ibfk_1` FOREIGN KEY (`arrival_id`) REFERENCES `customer_arrival` (`arrival_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `booking_arrival_ibfk_2` FOREIGN KEY (`Booking_ID`) REFERENCES `bookings` (`Booking_ID`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `booking_promotions`
--
ALTER TABLE `booking_promotions`
  ADD CONSTRAINT `booking_promotions_ibfk_1` FOREIGN KEY (`Booking_ID`) REFERENCES `bookings` (`Booking_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `booking_promotions_ibfk_2` FOREIGN KEY (`Promotion_ID`) REFERENCES `promotions` (`Promotion_ID`) ON DELETE CASCADE;

--
-- Constraints for table `booking_services`
--
ALTER TABLE `booking_services`
  ADD CONSTRAINT `booking_services_ibfk_1` FOREIGN KEY (`Booking_ID`) REFERENCES `bookings` (`Booking_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `booking_services_ibfk_2` FOREIGN KEY (`Service_ID`) REFERENCES `services` (`Service_ID`) ON DELETE CASCADE;

--
-- Constraints for table `complaints`
--
ALTER TABLE `complaints`
  ADD CONSTRAINT `complaints_ibfk_1` FOREIGN KEY (`Booking_ID`) REFERENCES `bookings` (`Booking_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `complaints_ibfk_2` FOREIGN KEY (`Customer_ID`) REFERENCES `customers` (`Customer_ID`) ON DELETE CASCADE;

--
-- Constraints for table `customer_arrival`
--
ALTER TABLE `customer_arrival`
  ADD CONSTRAINT `customer_arrival_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`Customer_ID`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `customer_arrival_ibfk_2` FOREIGN KEY (`hotel_ID`) REFERENCES `hotels` (`Hotel_ID`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `customer_arrival_ibfk_3` FOREIGN KEY (`Booking_ID`) REFERENCES `bookings` (`Booking_ID`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `hotels`
--
ALTER TABLE `hotels`
  ADD CONSTRAINT `hotels_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_accounts` (`User_ID`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `hotel_images`
--
ALTER TABLE `hotel_images`
  ADD CONSTRAINT `hotel_images_ibfk_1` FOREIGN KEY (`Hotel_ID`) REFERENCES `hotels` (`Hotel_ID`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`Booking_ID`) REFERENCES `bookings` (`Booking_ID`) ON DELETE CASCADE;

--
-- Constraints for table `promotions`
--
ALTER TABLE `promotions`
  ADD CONSTRAINT `promotions_ibfk_1` FOREIGN KEY (`Hotel_ID`) REFERENCES `hotels` (`Hotel_ID`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`Customer_ID`) REFERENCES `customers` (`Customer_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`Hotel_ID`) REFERENCES `hotels` (`Hotel_ID`) ON DELETE CASCADE;

--
-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`Hotel_ID`) REFERENCES `hotels` (`Hotel_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `rooms_ibfk_2` FOREIGN KEY (`Room_Type_ID`) REFERENCES `room_types` (`Room_Type_ID`) ON DELETE CASCADE;

--
-- Constraints for table `room_images`
--
ALTER TABLE `room_images`
  ADD CONSTRAINT `room_images_ibfk_1` FOREIGN KEY (`Room_ID`) REFERENCES `rooms` (`Room_ID`) ON DELETE CASCADE;

--
-- Constraints for table `room_types`
--
ALTER TABLE `room_types`
  ADD CONSTRAINT `room_types_ibfk_1` FOREIGN KEY (`Hotel_ID`) REFERENCES `hotels` (`Hotel_ID`) ON DELETE CASCADE;

--
-- Constraints for table `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_ibfk_1` FOREIGN KEY (`Hotel_ID`) REFERENCES `hotels` (`Hotel_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`Hotel_ID`) REFERENCES `hotels` (`Hotel_ID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
