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
## 2. Data Cleaning & Exploratori
1. Record Count: Calculate the total number of rows contained in the dataset.
2. Customer Count: Determine the number of distinct customers present in the dataset.
3. Category Count: Identify all unique product categories available in the dataset.
4. Null Value Check: Examine the dataset for any null or missing values and remove records with incomplete data.

```SQL
-- Data Exploratori & Cleaning
select * from retail_sales rs ;

select count(*) from retail_sales rs ;
select count(distinct customer_id) from retail_sales rs ;
select distinct rs.category  from retail_sales rs; 

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

drop table if exists retail_sales;
select * from retail_sales rs 
where rs.transactions_id  is null
	or rs.sale_date is null
	or rs.sale_time is null
	or rs.quantity is null
	or rs.price_per_unit  is null
	or rs.cogs is null
	or rs.total_sale is null;
```

# 3. Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:

### 1. Write a SQL query to retrieve all columns for sales mode on '2022-11-05'

```sql
select * from retail_sales rs 
where sale_date = "2022-11-05";
```
### 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
``` sql
select * from retail_sales rs
where rs.category = "Clothing" 
	  and rs.sale_date between '2022-11-31' and '2022-11-01'
	  and rs.quantiy >= 4 ;
```

### 3. Write a SQL query to calculate the total sales (total_sale) for each category.:
```sql
select rs.category, 
		sum(rs.total_sale) as total_sale,
		count(*) as total_order
from retail_sales rs
group by category ; 
```

### 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:.
```sql
select rs.category,
	round(avg(age)) as avg_age 
from retail_sales rs 
where rs.category = "Beauty"
group by category ;
```


### 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
```sql
select * 
from retail_sales rs 
where rs.total_sale > 1000
order by rs.total_sale  desc;
```


### 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
```sql
select rs.category,
rs.gender, 
count(*) as total_transaction  
from retail_sales rs 
group by rs.category,
		rs.gender 
order by category asc;
```

### 7. 	Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

```sql
select 
year,
month,
avg_sale
from
(
select EXTRACT(YEAR from sale_date) as year,
	   EXTRACT(MONTH from sale_date) as month,
	   AVG(rs.total_sale) as avg_sale,
		rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rengking
from retail_sales rs
group by 1, 2
) as t1
where rengking = 1;
```

8. Write a SQL query to find the top 5 customers based on the highest total sales:

```sql
select 
rs.customer_id ,
sum(rs.total_sale) as total_sales
from retail_sales rs 
group by 1 
order by 2 desc
limit 5;
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.:
select rs.category,
		count(distinct customer_id )	as total_customer
from retail_sales rs
group  by 1;
```

### 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

```sql
with
Hourly
as 
(
select *,
	case 
		when extract(hour from sale_time) < 12 then 'Morning'
		when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
		else
		'Evening'  
	end as shif
from retail_sales rs
)
select shif,
		count(*) as total_order
from hourly
group by 1
order by 2 desc;
```
## Findings
- Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- Sales Trends: Monthly analysis shows variations in sales, helping identify peak seasons.
- Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.

## Reports
- Sales Summary: A detailed report summarizing total sales, customer demographics, and category performance.
- Trend Analysis: Insights into sales trends across different months and shifts.
- Customer Insights: Reports on top customers and unique customer counts per category.

## Conclusion
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use
Clone the Repository: Clone this project repository from GitHub.
Set Up the Database: Run the SQL scripts provided in the database_setup.sql file to create and populate the database.
Run the Queries: Use the SQL queries provided in the analysis_queries.sql file to perform your analysis.
Explore and Modify: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Zero Analyst
This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!
  
-- end project

