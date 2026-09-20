# 🔗 Lab 09: Advanced SQL Joins (Self & Multi-Table)

## 📖 Overview
This repository advances the study of relational logic by tackling highly complex SQL operations. Operating as a fully standalone environment, it covers advanced queries for a corporate schema before culminating in a complete, graded assessment for a Library Management System.

## 🧠 Concepts Applied
* **Self Joins:** Addressed hierarchical data by joining a table onto itself (e.g., mapping an Employee directly to their Manager within the exact same table).
* **Multi-Table Joins:** Stitched together up to four distinct tables simultaneously to reconstruct the full lifecycle of a transaction (e.g., tracking a Loan back to the Member, the Book, and the Author).
* **Cross-Table Filtering:** Executed conditional logic across joined tables, such as isolating specific projects initiated within a certain fiscal year or tracking active (unreturned) library loans.

## 📁 Files Included
* `2024-SE-37-Lab09-Joins-B.sql`: A comprehensive, independent SQL script containing the setup and advanced queries for the corporate database, followed by the complete schema build and 10-query solution for the Library Assessment.

## 🚀 How to Run
Execute the .sql script in your preferred database environment. The script is entirely self-contained; it will establish the required databases (joins_lab_b and library_lab), insert all necessary testing data, and automatically run the 20 relational queries.
