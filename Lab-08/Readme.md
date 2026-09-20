# 🔗 Lab 08: SQL Joins (Inner, Left & Right)

## 📖 Overview
This repository focuses on resolving fragmented relational data by utilizing fundamental SQL JOIN operations. The script operates within a multi-table corporate schema, demonstrating how to extract cohesive business intelligence from separate entity tables (Departments, Employees, Projects, and Assignments).

## 🧠 Concepts Applied
* **Inner Joins:** Employed strict intersection logic to retrieve rows only when a match exists in both parent and child tables.
* **Left & Right Joins:** Utilized directional joins to guarantee data retention from primary tables (e.g., retrieving all departments, even those with zero assigned employees).
* **Null Value Filtering:** Leveraged outer joins combined with IS NULL checks to identify "orphaned" records, such as unassigned employees and dormant projects.
* **Full Outer Join Simulation:** Executed a UNION clause to combine Left and Right join outputs seamlessly.

## 📁 Files Included
* `2024-SE-37-Lab08-Joins-A.sql`: A self-contained script containing the corporate schema setup, sample data initialization, and the completion of all Part A join tasks.

## 🚀 How to Run
Execute the .sql script in any MySQL environment. It will sequentially build the joins_lab database, populate the four interconnected tables, and automatically run the 10 relational queries.
