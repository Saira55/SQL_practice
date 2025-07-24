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

SELECT COUNT(*)
FROM sql_practice1
