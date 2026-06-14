-- CREATE TABLE (DDL) Questions

/*
1. Create a table named students with:
student_id (INT)
student_name (VARCHAR(100))
age (INT)
*/
CREATE TABLE students (
    student_id    INT,
    student_name  VARCHAR(100),
    age           INT
);

/*
2. Create a table named employees with:
emp_id
emp_name
salary
*/
CREATE TABLE employees (
    emp_id      INT,
    emp_name    VARCHAR(20),
    salary      INT
);

/*
3. Create a table named products with:
product_id
product_name
price 
*/
CREATE TABLE products (
    product_id     INT,
    product_name   VARCHAR(20),
    price          INT
);

/*
4. Create a table named movies with:
movie_id
movie_name
release_date
*/
CREATE TABLE movies (
    movies_id       INT,
    movies_name     VARCHAR(100),
    release_date    DATE,
    payment_methods VARCHAR(15)
);

/*
5. Create a table named books with:
book_id
book_name
author_name  
*/
CREATE TABLE books (
    book_id      INT,
    book_name    VARCHAR(50), -- Increased from 20 to avoid truncation errors
    author_name  VARCHAR(50)
);

-- 6. Which data type would you use for: Product Name, Order Date, Salary
-- ANS: For product Name -> VARCHAR, Order Date -> DATE, Salary -> INT / DECIMAL / FLOAT

-- 7. What is the difference between INT and VARCHAR?
-- ANS: Both are used to store values, but the INT data type stores whole numerical values, while the VARCHAR data type stores variable-length character string values.

-- 8. What is the purpose of CREATE TABLE?
-- ANS: The purpose of CREATE TABLE is to create an empty format (in rows and columns) to store structured data.

-- 9. Write a table structure for storing mobile phone details.
CREATE TABLE mobile_details (
    phone_id   INT,
    model_Name VARCHAR(100), -- Fixed: Added explicit size to prevent 1-character default truncation
    brand      VARCHAR(50),  -- Fixed: Added explicit size to prevent 1-character default truncation
    price      INT
);

-- 10. Create a table named amazon_customers.
CREATE TABLE amazon_customer (
    customer_id    INT,
    customer_name  VARCHAR(20),
    customer_email VARCHAR(50)
);


-- INSERT INTO (DML) Questions

-- 11. Insert one record into the students table.
INSERT INTO students VALUES (1, 'Aman', 23);

-- 12. Insert three records into the products table.
-- Fixed: Added 3 distinct records as requested by the prompt
INSERT INTO products VALUES 
(121, 'Fridge', 15000),
(122, 'Microwave', 8000),
(123, 'Washing Machine', 25000);

-- 13. Insert a book named "Python Basics". 
INSERT INTO books (book_name) VALUES ('Python Basics');

-- 14. Insert an employee whose salary is 50000.
INSERT INTO employees (salary) VALUES (50000);

-- 15. Insert a movie released on '2025-01-01'.
INSERT INTO movies (release_date) VALUES ('2025-01-01');

-- 16. Insert five different customer records.
INSERT INTO amazon_customer VALUES (1, 'ajit Kumar', 'ajit123@gmail.com');
INSERT INTO amazon_customer VALUES (2, 'ramesh Kumar', 'ramesh123@gmail.com');
INSERT INTO amazon_customer VALUES (3, 'suresh Kumar', 'suresh123@gmail.com');
INSERT INTO amazon_customer VALUES (4, 'mahesh', 'mahesh123@gmail.com');
INSERT INTO amazon_customer VALUES (5, 'rakesh Kumar', 'rakesh123@gmail.com');

-- 17. Insert two products having the same price.
INSERT INTO products VALUES (101, 'bulb', 20);
INSERT INTO products VALUES (102, 'tubeLight', 20);

-- 18. Insert a record with payment method as UPI.
INSERT INTO movies (payment_methods) VALUES ('UPI');

-- 19. Insert a record with payment method as Credit Card.
INSERT INTO movies (payment_methods) VALUES ('CREDIT CARD');

-- 20. Insert your own sample data into amazon_customer.
INSERT INTO amazon_customer (customer_id, customer_name, customer_email) VALUES (1, 'raman', 'raman432@gmail.com');


-- SELECT Queries (DQL)

-- 21. Display all records from amazon_customer.
SELECT * FROM amazon_customer;

-- 22. Display only product_name.
SELECT product_name FROM products;

-- 23. Display only release_date.
SELECT release_date FROM movies;

-- 24. Display only price.
SELECT price FROM mobile_details;

-- 25. Display phone_id and price.
SELECT phone_id, price FROM mobile_details;

-- 26. Display the first row from amazon_customer.
SELECT TOP 1 * FROM amazon_customer;

-- 27. Display the first row from students.
SELECT TOP 1 * FROM students;


-- ORDER BY Questions
CREATE TABLE myntra_orders (
    order_id       INT,
    product_name   VARCHAR(100),
    order_date     DATE,
    total_price    DECIMAL(10, 2),
    payment_method VARCHAR(50)
);

INSERT INTO myntra_orders (order_id, product_name, order_date, total_price, payment_method)
VALUES 
(101, 'Running Shoes', '2026-06-10', 2499.00, 'UPI'),
(102, 'Denim Jacket',  '2026-06-12', 1899.50, 'Credit Card'),
(103, 'Cotton T-Shirt', '2026-06-10', 499.00,  'UPI'),
(104, 'Smart Watch',   '2026-06-14', 3500.00, 'Cash on Delivery'),
(105, 'Backpack',      '2026-06-12', 1200.00, 'Credit Card');

-- 28. Display all orders sorted by order_date ascending.
SELECT * FROM myntra_orders
ORDER BY order_date ASC;

-- 29. Display all orders sorted by order_date descending.
SELECT * FROM myntra_orders
ORDER BY order_date DESC;

-- 30. Sort products by product_name ascending.
SELECT product_name FROM myntra_orders
ORDER BY product_name ASC;

-- 31. Sort products by product_name descending.
SELECT product_name FROM myntra_orders
ORDER BY product_name DESC;

-- 32. Sort orders by total_price ascending.
SELECT * FROM myntra_orders
ORDER BY total_price ASC;

-- 33. Sort orders by payment_method.
SELECT * FROM myntra_orders 
ORDER BY payment_method;

-- 34. Sort first by order_date DESC and then product_name ASC.
SELECT * FROM myntra_orders
ORDER BY order_date DESC, product_name ASC;


-- DELETE & DROP Questions

-- 35. Delete all records from myntra_orders.
DELETE FROM myntra_orders;

-- 36. Drop all records from myntra_orders.
DROP TABLE myntra_orders;
