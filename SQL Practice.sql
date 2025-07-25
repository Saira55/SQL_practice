

CREATE TABLE sql_practice1
		  (transactions_id INT Primary Key, 
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR (15),
		age INt,
		category VARCHAR(15),
		quantiy INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
		)

SELECT *
FROM sql_practice1

---
SELECT COUNT(DISTINCT(gender)) AS gender_type
FROM sql_practice1

SELECT * FROM sql_practice1
WHERE Transactions_id IS NULL 
OR sale_date IS NULL OR  sale_time IS NULL OR  customer_id IS NULL OR gender IS NULL 
OR age IS NULL OR category IS NULL OR quantiy IS NULL OR  price_per_unit IS NULL OR cogs IS NULL OR total_sale IS NULL

DELETE FROM sql_practice1
WHERE total_sale IS NULL

--- dat aexploration--

----how many sale swe have

SELECT SUM(total_sale)
FROM sql_practice1


--- how many customers we have

SELECT COUNT(DISTINCT(customer_id))
FROM sql_practice1

SELECT customer_id, SUM(total_sale)
FROM sql_practice1
GROUP BY	customer_id
ORDER BY SUM(total_sale) DESC


SELECT DISTINCT category
FROM sql_practice1

---- business problem---
---Sales made on 2022-11-05

SELECT *
FROM sql_practice1
WHERE sale_date='2022-11-05'

---- category is clothing and quantity sold is more than 10 in month of Nov-2022

SELECT *
FROM sql_practice1
WHERE category = 'Clothing' AND
TO_CHAR(sale_date, 'MM-YYYY') = '11-2022' AND
quantiy >= 4

--- total sales for each category

SELECT category, sum(total_sale), count(customer_id)
FROM sql_practice1
GROUP BY category

----Avg age of people buying in the Beauty category
SELECT category, ROUND(Avg(age),2)
FROM sql_practice1
WHERE category='Beauty'
GROUP BY category

--- sales are more than 1000

SELECT *
FROM sql_practice1
WHERE total_sale > 1000

--- total number of transactions by each gender by each category


SELECT gender, category, COUNT(transactions_id)
FROM sql_practice1
GROUP BY gender, Category
-----
with hty as 
(
SELECT gender, category, 
COUNT(transactions_id) OVER(PARTITION BY gender, category) AS mty
FROM sql_practice1
)
SELECT gender, category, MAX(mty)
FROM hty

GROUP BY gender, category
----
--- sum of sales by category and gender but retaining all rows

with hty as 
(
SELECT *, 
SUM(total_sale) OVER(PARTITION BY category) AS mty
FROM sql_practice1
)
SELECT gender, category, MAX(mty)
FROM hty

GROUP BY gender, category

-----------USing INDEX for optimization
CREATE INDEX idx_cat_sale ON sql_practice1(category, sale_date);

EXPLAIN ANALYZE
SELECT *, 
       SUM(total_sale) OVER(PARTITION BY category) AS mty
FROM sql_practice1;
---
----avg sales for each month and then best selling monthfor each year

with fgh as(
SELECT TO_CHAR(sale_date, 'YYYY') AS yr, TO_CHAR(sale_date, 'Month') AS mth, 
AVG (total_sale) OVER (PARTITION BY TO_CHAR(sale_date, 'YYYY-mm')) AS avg_sales
FROM sql_practice1)

SELECT yr, mth, MAX(avg_sales)
FROM fgh
GROUP BY yr, mth
ORDER BY MAX(avg_sales) DESC

-----
WITH monthly_avg AS(
SELECT TO_CHAR(sale_date, 'yyyy') AS yr , TO_CHAR(sale_date, 'mm'), TO_CHAR(sale_date, 'yyyy-mm'), 
ROUND(AVG(total_sale)::numeric,2) AS avg_sales
FROM sql_practice1
GROUP BY TO_CHAR(sale_date, 'yyyy'), TO_CHAR(sale_date, 'mm'), TO_CHAR(sale_date, 'yyyy-mm')
),
rank_sales AS(
SELECT *, RANK() OVER(PARTITION BY yr ORDER BY avg_sales DESC) AS rnk

FROM monthly_avg
)

SELECT *
FROM rank_sales
WHERE rnk=1
ORDER BY yr