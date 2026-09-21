# 🚗 CarGo Rentals Management System

A robust relational database solution designed to replace manual spreadsheet operations for a local car rental company (CarGo Rentals). This project implements core database management principles including relational schema design, normalization up to 3NF, advanced SQL JOINs, views, stored procedures, triggers, and query performance optimization.

---

## 📋 Table of Contents
1. [Project Overview & Problem Statement](#project-overview--problem-statement)
2. [Database Design & Architecture](#database-design--architecture)
3. [Normalization (1NF to 3NF)](#normalization-1nf-to-3nf)
4. [SQL Queries (Task 3)](#sql-queries-task-3)
5. [Views, Stored Procedures & Triggers](#views-stored-procedures--triggers)
6. [Performance Optimization (Task 7)](#performance-optimization-task-7)
7. [How to Setup & Run](#how-to-setup--run)

---

## 1. Project Overview & Problem Statement
CarGo Rentals previously managed customers, vehicles, rentals, and payments using flat spreadsheets. As business grew, this led to:
* **Data Redundancy:** Repeating customer and vehicle details across multiple rows.
* **Inconsistent Records:** Risk of update anomalies (e.g., mismatched phone numbers or daily rates).
* **Reporting Bottlenecks:** Difficulty in tracking active rentals and generating financial summaries.

This relational database solution eliminates these issues by enforcing strict constraints, automating workflows via triggers, and centralizing data storage.

---

## 2. Database Design & Architecture
The database (`cargorentals`) consists of four normalized tables linked through primary and foreign keys:

| Table Name | Description | Key Columns |
| :--- | :--- | :--- |
| **customers** | Stores client profile and contact details | `customer_id` (PK), `phone` (UNIQUE) |
| **vehicles** | Maintains vehicle inventory and current status | `vehicle_no` (PK), `daily_rate`, `status` |
| **rentals** | Records booking transactions linking customers & vehicles | `rental_id` (PK), `customer_id` (FK), `vehicle_no` (FK) |
| **payments** | Handles financial transactions for each rental | `payment_id` (PK), `rental_id` (FK, UNIQUE), `amount` |

### Key Constraints Applied:
* **Primary Keys (PK):** Ensures unique identification of every record.
* **Foreign Keys (FK):** Maintains referential integrity between tables with `ON DELETE CASCADE`.
* **CHECK Constraints:** Validates that daily rates and amounts are positive (`> 0`), and rental statuses only accept valid states (`Available`, `Rented`, `Maintenance`, `Active`, `Completed`).
* **UNIQUE Constraints:** Prevents duplicate customer phone numbers and ensures a 1:1 relationship between rentals and payments.

---

## 3. Normalization (1NF to 3NF)
The system was systematically normalized from an unnormalized flat spreadsheet format to 3rd Normal Form (3NF) to eliminate anomalies:
* **1NF:** Ensured atomic values and eliminated repeating groups.
* **2NF:** Removed partial dependencies by separating customer and vehicle attributes from rental transactions.
* **3NF:** Eliminated transitive dependencies by isolating customer details and vehicle models into dedicated parent tables, successfully resolving **Insertion, Update, and Deletion anomalies**.

---

## 4. SQL Queries (Task 3)
The project includes four business-critical JOIN queries:
1. **Basic Rental Details (INNER JOIN):** Retrieves customer names, vehicle numbers, models, and rental dates for every active booking.
2. **Customer Coverage (LEFT JOIN):** Displays all customers and their rented vehicles, including customers who have never made a booking.
3. **Fleet Status (LEFT JOIN):** Lists all vehicles and their current rental information, ensuring unrented vehicles are also visible.
4. **Rental Frequency (GROUP BY):** Calculates the total number of rentals made by each individual customer, including those with zero rentals.

---

## 5. Views, Stored Procedures & Triggers

### 📊 Database View (`rental_summary_view`)
Consolidates customer, vehicle, rental, and payment details into a single virtual table, enabling management to instantly generate financial and operational reports without writing complex multi-table joins.

### ⚙️ Stored Procedure (`addNewRental`)
Automates the rental registration process:
* Accepts customer ID, vehicle number, rental date, and return date.
* Dynamically calculates total rental duration in days and multiplies it by the vehicle's daily rate to compute the final bill.
* Inserts the new rental record safely.

### ⚡ Triggers (Automation & Integrity)
1. **`prevent_double_booking` (BEFORE INSERT):** Checks vehicle availability before a booking is made and rejects duplicate rentals using custom error signaling (`SQLSTATE '45000'`).
2. **`update_car_status` (AFTER INSERT):** Automatically updates a vehicle's status from `'Available'` to `'Rented'` the moment a booking is inserted.
3. **`release_car_on_return` (AFTER UPDATE):** Automatically resets a vehicle's status back to `'Available'` when a rental status is marked as `'Completed'`.

---

## 6. Performance Optimization (Task 7)
* **Identified Inefficiency:** Foreign key columns (`customer_id`, `vehicle_no`) in the `rentals` table lacked explicit secondary indexes, which would lead to full table scans (`type = ALL`) during large-scale JOIN operations.
* **Implemented Solution:** Created B-Tree indexes on foreign keys:
  ```sql
  CREATE INDEX idx_rentals_customer ON rentals (customer_id);
  CREATE INDEX idx_rentals_vehicle  ON rentals (vehicle_no);
