-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 03, 2026 at 05:53 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pos`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `description`) VALUES
(1, 'Electronics', 'Mobile phones, laptops, and gadgets'),
(2, 'Clothing', 'Mens and womens apparel'),
(3, 'Groceries', 'Food and daily essentials'),
(4, 'Books', 'Educational and fiction books'),
(5, 'Sports', 'Sports equipment and accessories');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inventory_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity_on_hand` int(11) NOT NULL DEFAULT 0,
  `reserved_quantity` int(11) NOT NULL DEFAULT 0,
  `available_stock` int(11) GENERATED ALWAYS AS (`quantity_on_hand` - `reserved_quantity`) STORED,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`inventory_id`, `product_id`, `quantity_on_hand`, `reserved_quantity`, `last_updated`) VALUES
(1, 1, 50, 5, '2026-03-13 04:18:54'),
(2, 2, 30, 3, '2026-03-13 04:18:54'),
(3, 3, 100, 10, '2026-03-13 04:18:54'),
(4, 4, 200, 15, '2026-03-13 04:18:54'),
(5, 5, 150, 8, '2026-03-13 04:18:54'),
(6, 6, 500, 20, '2026-03-13 04:18:54'),
(7, 7, 300, 12, '2026-03-13 04:18:54'),
(8, 8, 80, 5, '2026-03-13 04:18:54'),
(9, 9, 120, 7, '2026-03-13 04:18:54'),
(10, 10, 40, 2, '2026-03-13 04:18:54');

-- --------------------------------------------------------

--
-- Table structure for table `ordered_items`
--

CREATE TABLE `ordered_items` (
  `ordered_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price_at_purchase` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ordered_items`
--

INSERT INTO `ordered_items` (`ordered_item_id`, `order_id`, `product_id`, `quantity`, `price_at_purchase`, `subtotal`) VALUES
(1, 1, 1, 1, 65000.00, 65000.00),
(2, 1, 3, 1, 4500.00, 4500.00),
(3, 2, 4, 1, 2500.00, 2500.00),
(4, 2, 5, 1, 3500.00, 3500.00),
(5, 3, 6, 2, 1200.00, 2400.00),
(6, 3, 7, 1, 2800.00, 2800.00),
(7, 4, 2, 1, 95000.00, 95000.00),
(8, 4, 3, 1, 4500.00, 4500.00),
(9, 5, 8, 1, 850.00, 850.00),
(10, 5, 9, 1, 450.00, 450.00),
(11, 6, 10, 2, 3200.00, 6400.00),
(12, 6, 4, 1, 2500.00, 2500.00);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_date` datetime DEFAULT current_timestamp(),
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(50) DEFAULT 'Completed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `order_date`, `total_amount`, `status`) VALUES
(1, 4, '2024-03-01 10:30:00', 69500.00, 'Completed'),
(2, 5, '2024-03-02 14:15:00', 6000.00, 'Completed'),
(3, 6, '2024-03-03 11:20:00', 4000.00, 'Completed'),
(4, 4, '2024-03-05 09:45:00', 99500.00, 'Completed'),
(5, 5, '2024-03-08 16:00:00', 1300.00, 'Pending'),
(6, 6, '2024-03-10 13:30:00', 7000.00, 'Completed');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `category_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `name`, `description`, `price`, `category_id`, `created_at`) VALUES
(1, 'Samsung Galaxy A54', '128GB smartphone with 5G', 65000.00, 1, '2026-03-13 04:18:54'),
(2, 'HP Laptop 15s', 'Intel i5, 8GB RAM, 512GB SSD', 95000.00, 1, '2026-03-13 04:18:54'),
(3, 'Wireless Earbuds', 'Bluetooth earbuds with charging case', 4500.00, 1, '2026-03-13 04:18:54'),
(4, 'Mens Kurta', 'Cotton kurta - white color', 2500.00, 2, '2026-03-13 04:18:54'),
(5, 'Womens Lawn Suit', '3-piece unstitched lawn', 3500.00, 2, '2026-03-13 04:18:54'),
(6, 'Basmati Rice 5kg', 'Premium quality basmati rice', 1200.00, 3, '2026-03-13 04:18:54'),
(7, 'Cooking Oil 5L', 'Canola cooking oil', 2800.00, 3, '2026-03-13 04:18:54'),
(8, 'Physics Book', 'Class 12 Physics textbook', 850.00, 4, '2026-03-13 04:18:54'),
(9, 'Novel - Peer e Kamil', 'Urdu novel by Umera Ahmed', 450.00, 4, '2026-03-13 04:18:54'),
(10, 'Cricket Bat', 'Kashmir willow cricket bat', 3200.00, 5, '2026-03-13 04:18:54');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`) VALUES
(1, 'Admin'),
(2, 'Salesman'),
(3, 'Customer');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `password`, `phone`, `role_id`, `created_at`) VALUES
(1, 'Admin Khan', 'admin@pos.com', 'admin123', '0300-1111111', 1, '2026-03-13 04:18:54'),
(2, 'Salesman Ali', 'ali@pos.com', 'ali123', '0301-2222222', 2, '2026-03-13 04:18:54'),
(3, 'Salesman Ahmed', 'ahmed@pos.com', 'ahmed123', '0302-3333333', 2, '2026-03-13 04:18:54'),
(4, 'Customer Fatima', 'fatima@email.com', 'fatima123', '0303-4444444', 3, '2026-03-13 04:18:54'),
(5, 'Customer Hassan', 'hassan@email.com', 'hassan123', '0304-5555555', 3, '2026-03-13 04:18:54'),
(6, 'Customer Ayesha', 'ayesha@email.com', 'ayesha123', '0305-6666666', 3, '2026-03-13 04:18:54');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventory_id`),
  ADD UNIQUE KEY `product_id` (`product_id`);

--
-- Indexes for table `ordered_items`
--
ALTER TABLE `ordered_items`
  ADD PRIMARY KEY (`ordered_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inventory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `ordered_items`
--
ALTER TABLE `ordered_items`
  MODIFY `ordered_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ordered_items`
--
ALTER TABLE `ordered_items`
  ADD CONSTRAINT `ordered_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ordered_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
