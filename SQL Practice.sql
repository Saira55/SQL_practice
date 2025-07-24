

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

