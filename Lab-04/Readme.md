# 🗃️ Lab 07 / Open-Ended Lab: Car Rental Management System

## 📖 Overview
This repository contains the complete implementation and analysis for the **Car Rental Management System** open-ended database lab. The project demonstrates the transition from unorganized spreadsheet data to a fully structured relational database, incorporating advanced SQL features like Normalization (1NF to 3NF), complex JOINs, Views, Triggers, and Stored Procedures.

---

## 🧠 Concepts & Tasks Implemented
* **Database Design & Constraints:** Created normalized tables (`customers`, `vehicles`, `rentals`, `payments`) with appropriate Primary Keys, Foreign Keys, `CHECK`, and `DEFAULT` constraints.
* **Normalization (1NF - 3NF):** Resolved data redundancy, insertion/update/deletion anomalies, and achieved strict third normal form.
* **Complex JOIN Queries:** Answered real-world business queries using `INNER JOIN`, `LEFT JOIN`, and aggregate functions (`GROUP BY`, `COUNT`).
* **Views:** Created a consolidated reporting view (`rental_summary_view`) for administrative tracking.
* **Triggers:** Implemented an automated database trigger (`update_car_status`) to automatically switch vehicle availability status upon new rentals.
* **Stored Procedures:** Developed a transactional stored procedure (`addNewRental`) for rental registration and automated bill calculations based on daily rates.

---

## 📁 Files Included
* `car_rental_script.sql`: The main SQL file containing database creation, table schemas, sample data insertion, JOIN queries, views, triggers, and stored procedures.
* `Report.docx`: Detailed lab report containing normalization breakdown and query outputs.

---

## 🚀 How to Run
1. Open your MySQL environment (e.g., XAMPP phpMyAdmin or MySQL Workbench).
2. Import or paste the script from `car_rental_script.sql`.
3. Run the script to automatically build the database, populate realistic sample data, and test the procedures.

---
**Student Info:**  
* **Name:** Hasnain Malik  
* **Roll Number:** 2024-SE-37  
* **Course:** Database Management Systems
