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

select * from retail_sales rs 
limit 10;

select count(*) from retail_sales rs ;


select * from retail_sales rs 
where rs.transactions_id  is null
	or rs.sale_date is null
	or rs.sale_time is null
	or rs.quantiy is null
	or rs.price_per_unit  is null
	or rs.cogs is null
	or rs.total_sale is null;

delete from retail_sales rs 
where rs.transactions_id  is null
	or rs.sale_date is null
	or rs.sale_time is null
	or rs.quantiy is null
	or rs.price_per_unit  is null
	or rs.cogs is null
	or rs.total_sale is null;

select count(*) from retail_sales rs 
;

--  data exploration
-- How many sales we have?
select count(*) as total_sales from retail_sales rs ;

-- How many unique customer we have?
select count(distinct customer_id) from retail_sales rs ;

-- how many categroy we have
select distinct category from retail_sales rs;

-- Data Analysis & Business key Problem & Answer
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales mode on '2022-11-05'
select * from retail_sales rs 
where sale_date = "2022-11-05";

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
-- and the quantity sold is more than 4 in the month of Nov-2022:
select * from retail_sales rs
where rs.category = "Clothing" 
	  and rs.sale_date between '2022-11-31' and '2022-11-01'
	  and rs.quantiy >= 4 ;


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.:
select rs.category, 
		sum(rs.total_sale) as total_sale,
		count(*) as total_order
from retail_sales rs
group by category ; 

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:.
select rs.category,
	round(avg(age)) as avg_age 
from retail_sales rs 
where rs.category = "Beauty"
group by category ;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select * 
from retail_sales rs 
where rs.total_sale > 1000
order by rs.total_sale  desc;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select rs.category,
rs.gender, 
count(*) as total_transaction  
from retail_sales rs 
group by rs.category,
		rs.gender 
order by category asc;



-- Q.7 	Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
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


-- Q.8 **Write a SQL query to find the top 5 customers based on the highest total sales **:
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


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
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

-- end project




select * from retail_sales rs ;

select EXTRACT(minute from current_time);

