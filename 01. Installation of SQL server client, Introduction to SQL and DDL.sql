/* ==================================================
   DDL (Data Definition Language)
   Used to define database structure
   ================================================== */

CREATE TABLE amazon_orders
(
    order_id        INT,
    order_date      DATE,
    product_name    VARCHAR(100),
    total_price     DECIMAL(6,2),
    payment_method  VARCHAR(20)
);

-- Delete the entire table structure
-- DROP TABLE amazon_orders;


/* ==================================================
   DML (Data Manipulation Language)
   Used to insert, update, and delete data
   ================================================== */

INSERT INTO amazon_orders
VALUES (1, '2022-10-01', 'Baby Milk', 30.50, 'UPI');

INSERT INTO amazon_orders
VALUES (2, '2022-10-02', 'Baby Powder', 130.00, 'Credit Card');

INSERT INTO amazon_orders
VALUES (3, '2022-10-01', 'Baby Cream', 30.50, 'UPI');

INSERT INTO amazon_orders
VALUES (4, '2022-10-02', 'Baby Soap', 130.00, 'Credit Card');

-- Delete all records from the table
-- DELETE FROM amazon_orders;


/* ==================================================
   DQL (Data Query Language)
   Used to retrieve data
   ================================================== */

-- Display all columns and rows
SELECT *
FROM amazon_orders;

-- Display specific columns only
SELECT
    product_name,
    order_date,
    total_price
FROM amazon_orders;

-- Display only the first row
SELECT TOP 1 *
FROM amazon_orders;

-- Sort data
SELECT *
FROM amazon_orders
ORDER BY
    order_date DESC,
    product_name DESC,
    payment_method ASC;


/* ==================================================
   Common SQL Data Types
   ==================================================

   INT            -> 1, 2, 3, -1, -2
   DATE           -> '2025-06-01'
   VARCHAR(100)   -> 'Baby Milk'
   DECIMAL(6,2)   -> 1234.56

================================================== */