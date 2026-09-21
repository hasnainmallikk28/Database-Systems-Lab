-- =====================================================================
-- DATABASE MANAGEMENT SYSTEM - OPEN-ENDED LAB ASSIGNMENT
-- Project Name: CarGo Rentals Management System
-- Database Name: cargorentals
-- Description: Complete SQL script containing database creation, table 
-- definitions, constraints, sample data, views, triggers, stored 
-- procedures, optimization indexes, and required JOIN queries.
-- =====================================================================

-- Step 1: Create and Select Database
DROP DATABASE IF EXISTS cargorentals;
CREATE DATABASE cargorentals;
USE cargorentals;

-- =====================================================================
-- Step 2: Table Creation with Proper Data Types and Constraints (Task 1)
-- =====================================================================

-- Customers Table
CREATE TABLE customers (
  customer_id   INT AUTO_INCREMENT PRIMARY KEY,
  customer_name VARCHAR(100) NOT NULL,
  phone         VARCHAR(15)  NOT NULL UNIQUE,
  email         VARCHAR(100),
  address       VARCHAR(150)
) ENGINE=InnoDB;

-- Vehicles Table with Check Constraints on Daily Rate and Status
CREATE TABLE vehicles (
  vehicle_no  VARCHAR(15) PRIMARY KEY,
  model_name  VARCHAR(50) NOT NULL,
  category    VARCHAR(30) DEFAULT 'Sedan',
  daily_rate  DECIMAL(10,2) NOT NULL CHECK (daily_rate > 0),
  status      VARCHAR(20) NOT NULL DEFAULT 'Available' CHECK (status IN ('Available','Rented','Maintenance'))
) ENGINE=InnoDB;

-- Rentals Table with Foreign Keys and Date Validation Constraints
CREATE TABLE rentals (
  rental_id   INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  vehicle_no  VARCHAR(15) NOT NULL,
  rental_date DATE NOT NULL,
  return_date DATE CHECK (return_date IS NULL OR return_date >= rental_date),
  status      VARCHAR(20) NOT NULL DEFAULT 'Active' CHECK (status IN ('Active','Completed')),
  CONSTRAINT fk_rentals_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
  CONSTRAINT fk_rentals_vehicle FOREIGN KEY (vehicle_no) REFERENCES vehicles(vehicle_no) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Payments Table linked to Rentals (1:1 Relationship)
CREATE TABLE payments (
  payment_id     INT AUTO_INCREMENT PRIMARY KEY,
  rental_id      INT NOT NULL UNIQUE,
  amount         DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
  payment_date   DATE,
  payment_method VARCHAR(20) NOT NULL DEFAULT 'Cash' CHECK (payment_method IN ('Cash','Card','Online')),
  CONSTRAINT fk_payments_rental FOREIGN KEY (rental_id) REFERENCES rentals(rental_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- =====================================================================
-- Step 3: Insert Realistic Sample Data
-- =====================================================================

INSERT INTO customers (customer_name, phone, email, address) VALUES
('Ali Khan',   '0300-1234567', 'ali.khan@mail.com',   'Muzaffarabad'),
('Ahmed Raza', '0321-2345678', 'ahmed.raza@mail.com', 'Rawalakot'),
('Sara Bilal', '0333-3456789', 'sara.bilal@mail.com', 'Mirpur');

INSERT INTO vehicles (vehicle_no, model_name, category, daily_rate, status) VALUES
('ABC-123', 'Toyota Corolla', 'Sedan',     5000.00, 'Available'),
('XYZ-789', 'Honda Civic',    'Sedan',     5500.00, 'Available'),
('LHR-456', 'Suzuki Alto',    'Hatchback', 3500.00, 'Available');

INSERT INTO rentals (customer_id, vehicle_no, rental_date, return_date, status) VALUES
(1, 'LHR-456', '2026-09-01', '2026-09-04', 'Completed');

INSERT INTO payments (rental_id, amount, payment_date, payment_method) VALUES
(1, 10500.00, '2026-09-04', 'Cash');

-- =====================================================================
-- Step 4: Database View for Consolidated Reporting (Task 4)
-- =====================================================================

CREATE VIEW rental_summary_view AS
SELECT  
    r.rental_id, 
    c.customer_name, 
    c.phone,
    v.vehicle_no, 
    v.model_name,
    r.rental_date, 
    r.return_date, 
    r.status AS rental_status,
    p.amount, 
    p.payment_method
FROM rentals r
JOIN customers c ON r.customer_id = c.customer_id
JOIN vehicles  v ON r.vehicle_no  = v.vehicle_no
LEFT JOIN payments p ON r.rental_id = p.rental_id;

-- =====================================================================
-- Step 5: Triggers for Business Logic Automation (Task 5 & 6)
-- =====================================================================

DELIMITER $$

-- Trigger 1: Prevent Double Booking of an Already Rented Vehicle
CREATE TRIGGER prevent_double_booking
BEFORE INSERT ON rentals
FOR EACH ROW
BEGIN
  DECLARE v_status VARCHAR(20);
  SELECT status INTO v_status FROM vehicles WHERE vehicle_no = NEW.vehicle_no;
  IF v_status <> 'Available' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'This vehicle is already rented.';
  END IF;
END$$

-- Trigger 2: Automatically Update Vehicle Status to 'Rented' on New Rental
CREATE TRIGGER update_car_status
AFTER INSERT ON rentals
FOR EACH ROW
BEGIN
  UPDATE vehicles SET status = 'Rented' WHERE vehicle_no = NEW.vehicle_no;
END$$

-- Trigger 3: Release Vehicle Status back to 'Available' upon Rental Return/Completion
CREATE TRIGGER release_car_on_return
AFTER UPDATE ON rentals
FOR EACH ROW
BEGIN
  IF NEW.status = 'Completed' AND OLD.status = 'Active' THEN
    UPDATE vehicles SET status = 'Available' WHERE vehicle_no = NEW.vehicle_no;
  END IF;
END$$

DELIMITER ;

-- =====================================================================
-- Step 6: Stored Procedure for Registering Rentals (Task 6)
-- =====================================================================

DELIMITER $$

CREATE PROCEDURE addNewRental (
  IN  p_customer_id  INT,
  IN  p_vehicle_no   VARCHAR(15),
  IN  p_rental_date  DATE,
  IN  p_return_date  DATE,
  OUT p_total_charge DECIMAL(10,2)
)
BEGIN
  DECLARE v_rate DECIMAL(10,2);
  DECLARE v_days INT;
  
  -- Fetch daily rate of the vehicle
  SELECT daily_rate INTO v_rate FROM vehicles WHERE vehicle_no = p_vehicle_no;
  
  -- Calculate rental duration and total charge
  SET v_days = DATEDIFF(p_return_date, p_rental_date);
  IF v_days <= 0 THEN
    SET v_days = 1;
  END IF;
  SET p_total_charge = v_days * v_rate;
  
  -- Insert the new rental record
  INSERT INTO rentals (customer_id, vehicle_no, rental_date, return_date, status)
  VALUES (p_customer_id, p_vehicle_no, p_rental_date, p_return_date, 'Active');
END$$

DELIMITER ;

-- =====================================================================
-- Step 7: Performance Optimization & Indexes (Task 7)
-- =====================================================================

-- Create indexes on foreign key columns to avoid full table scans during joins
CREATE INDEX idx_rentals_customer ON rentals (customer_id);
CREATE INDEX idx_rentals_vehicle  ON rentals (vehicle_no);

-- =====================================================================
-- Step 8: Required JOIN Queries (Task 3)
-- =====================================================================

-- Query 1: Display customer name, vehicle number, model, rental date, and return date for every rental
SELECT c.customer_name, v.vehicle_no, v.model_name, r.rental_date, r.return_date
FROM rentals r
JOIN customers c ON r.customer_id = c.customer_id
JOIN vehicles  v ON r.vehicle_no  = v.vehicle_no;

-- Query 2: Display all customers and the vehicles they have rented (including customers with no rentals)
SELECT c.customer_name, c.phone, v.vehicle_no, v.model_name
FROM customers c
LEFT JOIN rentals  r ON c.customer_id = r.customer_id
LEFT JOIN vehicles v ON r.vehicle_no  = v.vehicle_no;

-- Query 3: Display all vehicles and their current rental information (including unrented vehicles)
SELECT v.vehicle_no, v.model_name, v.status, r.rental_date, r.return_date
FROM vehicles v
LEFT JOIN rentals r ON v.vehicle_no = r.vehicle_no AND r.status = 'Active';

-- Query 4: Display the total number of rentals made by each customer (including those with 0 rentals)
SELECT c.customer_name, COUNT(r.rental_id) AS total_rentals
FROM customers c
LEFT JOIN rentals r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.customer_name;
