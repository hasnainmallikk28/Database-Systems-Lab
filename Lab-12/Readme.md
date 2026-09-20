# 📊 Lab 12: Aggregate Functions, GROUP BY, HAVING, and Assessment

## 📖 Overview
This repository covers data summarization techniques using SQL aggregate functions. It demonstrates how to collapse row-level information into meaningful business intelligence metrics using whole-table calculations, categorical groupings, group-level filtering, relational joins, and concludes with the comprehensive University Database Assessment Problem.

## 🧠 Concepts Applied
* **Core Aggregates:** Utilized COUNT(), SUM(), AVG(), MIN(), and MAX() to evaluate volume, pricing, and student performance metrics.
* **Null Handling & Distinct Metrics:** Managed NULL behaviors and applied COUNT(DISTINCT) to isolate unique categories, cities, and student locations.
* **Categorical Grouping (GROUP BY):** Structured multi-row outputs into per-category and per-department reports following standard execution rules.
* **Group Filtering (HAVING):** Differentiated row-level pre-filtering (WHERE) from post-aggregation group filtering (HAVING).
* **Complex Joins & Subqueries:** Blended LEFT JOIN and INNER JOIN operations with aggregate functions to capture zero-activity metrics and top-performing entities.

## 📁 Files Included
* `2024-SE-37-Lab12-Aggregatefunctions.sql`: A fully self-contained script containing the Retail Store schema setup, test data insertion, Parts A & B aggregate queries, and the complete University Database Assessment (Q1–Q12).

## 🚀 How to Run
Execute the .sql script in any MySQL environment. It will independently establish the required databases (agg_lab and uni_lab), populate the interconnected tables, and automatically run the complete sequence of aggregate operations and assessment queries.
