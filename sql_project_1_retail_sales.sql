--sql retail analysis
create database sqlprojectp1;

create table retail_sales(
         transactions_id int primary key,
		 sale_date	date,
		 sale_time	time,
		 customer_id int,
		 gender	varchar(10),
		 age	int,
		 category varchar(25),	
		 quantiy	int,
		 price_per_unit	float,
		 cogs	float,
		 total_sale float

);
select count(*) from retail_sales;

select * from retail_sales
where  sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

delete from retail_sales where sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

select count(distinct customer_id)from retail_sales;
--q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from retail_sales where sale_date='2022-11-05'
--q2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4;
--q3 Write a SQL query to calculate the total sales (total_sale) for each category.:
select category, sum(total_sale) as net_sale , count(*) as total_orders 
from retail_sales group by category;
--q4Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select avg(age) from retail_sales where category='Beauty';
--q5Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select * from retail_sales where total_sale>1000;
--q6Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select category,gender,count(*)as total_transactions from retail_sales
group by category,gender order by category;

--q7Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

--q8Write a SQL query to find the top 5 customers based on the highest total sales
select customer_id ,sum(total_sale)as total_sale
from retail_sales group by 1 order by 2 desc limit 5; 

--q9Write a SQL query to find the number of unique customers who purchased items from each category.:
select category,count(distinct customer_id)as unique_customers from retail_sales group by 1;
--q10Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

SELECT
  CASE 
    WHEN extract (hour from sale_time) < 12 THEN 'Morning'
    WHEN extract (hour from sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift,
  COUNT(*) AS number_of_orders
  from retail_sales group by shift;


select extract (hour from current_time);


--end of project










