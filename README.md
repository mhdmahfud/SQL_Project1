# SQL_Project1 Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis
**Level**: Beginner
**Database**: p1_retail_db

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

**objectives**
1. Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
2. Data Cleaning: Identify and remove any records with missing or null values.
3. Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
4. Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup
- **Database Creation**: The project starts by creating a database named `sql_project_p3`.
- **Table Creation**: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.
  
```sql
-- SQL Retail Sales Analysis 
create database sql_project_p3;

-- Create Tabel
drop table if exists retail_sales;
create table retail_sales(
			transactions_id INT primary key ,
			sale_date date,
			sale_time time,
			customer_id int,
			gender varchar(20),
			age int,
			category varchar(12),
			quantiy int,
			price_per_unit int,
			cogs float,
			total_sale float
);
```
##2. Data Cleaning & Exploratori
1. Record Count: Calculate the total number of rows contained in the dataset.
2. Customer Count: Determine the number of distinct customers present in the dataset.
3. Category Count: Identify all unique product categories available in the dataset.
4. Null Value Check: Examine the dataset for any null or missing values and remove records with incomplete data.

