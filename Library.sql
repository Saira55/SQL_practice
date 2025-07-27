--- Libraray Managemnet system project--

---Create tables---

DROP TABLE IF EXISTS branch;
CREATE TABLE branch(

branch_id VARCHAR(10) PRIMARY KEY,
manager_id VARCHAR(10),
branch_address VARCHAR(100),
contact_no VARCHAR(10)

)


CREATE TABLE employees(
	emp_id VARCHAR(10) PRIMARY KEY,
	emp_name VARCHAR(20),
	position VARCHAR(20),
	salary INT,
	branch_id VARCHAR(10)  --FK
)

CREATE TABLE books(
isbn VARCHAR(25) PRIMARY KEY,
book_title VARCHAR(75),
category VARCHAR(25),
rental_price FLOAT,
status VARCHAR(25),
author VARCHAR(25),
publisher VARCHAR(25)

);

CREATE TABLE members(
member_id VARCHAR(25) PRIMARY KEY,
member_name VARCHAR(25),
member_address VARCHAR(25),
reg_date DATE

);

CREATE TABLE issued_status(
issued_id  VARCHAR(10) PRIMARY KEY,
issued_member_id VARCHAR(10), --FK
issued_book_name VARCHAR(75),
issued_date DATE,
issued_book_isbn VARCHAR(25), --FK
issued_emp_id VARCHAR(10) --FK

)

CREATE TABLE return_status(
return_id VARCHAR(10) PRIMARY KEY,
issued_id VARCHAR(10),
return_book_name VARCHAR(75),
return_date DATE,
return_book_isbn VARCHAR(25)

)

---Foreign Key
ALTER TABLE
