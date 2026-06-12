/* ============================================================
SQL NOTES - FILTERING & PATTERN MATCHING
========================================

Topics Covered:

1. TOP
2. DISTINCT
3. WHERE
4. Comparison Operators
5. BETWEEN
6. IN / NOT IN
7. AND / OR
8. Calculated Columns
9. LIKE Operator
10. Wildcards (% and _)

============================================================ */

/* ============================================================
SAMPLE TABLE
============================================================ */

CREATE TABLE orders
(
order_id        VARCHAR(20),
order_date      DATETIME,
customer_name   VARCHAR(100),
ship_mode       VARCHAR(30),
segment         VARCHAR(30),
quantity        INT,
sales           DECIMAL(10,2),
profit          DECIMAL(10,2)
);

/* ============================================================
SAMPLE DATA
============================================================ */

INSERT INTO orders VALUES
('CA-2020-1001','2020-12-08 10:00:00','Chris Evans','First Class','Consumer',5,1000,200);

INSERT INTO orders VALUES
('CA-2020-1002','2020-12-09 11:00:00','Steven Smith','Second Class','Corporate',3,1500,300);

INSERT INTO orders VALUES
('CA-2020-1003','2020-12-10 09:30:00','Alice Brown','Same Day','Consumer',4,1200,250);

INSERT INTO orders VALUES
('CA-2020-1004','2020-12-11 02:15:00','Bob Martin','Standard Class','Home Office',2,1800,400);

INSERT INTO orders VALUES
('CA-2020-1005','2020-12-12 04:00:00','Clara Johnson','First Class','Consumer',6,2200,500);

INSERT INTO orders VALUES
('CA-2020-1006','2020-12-13 12:30:00','Allen Stone','Same Day','Corporate',7,2500,600);

INSERT INTO orders VALUES
('CA-2020-1007','2020-12-14 08:45:00','Kevin Parker','Second Class','Consumer',5,1700,350);

INSERT INTO orders VALUES
('CA-2020-1008','2020-12-15 06:20:00','Ariana Grande','First Class','Home Office',8,3000,700);

/* ============================================================
TOP
Returns first N rows
============================================================ */

SELECT TOP 5 *
FROM orders
ORDER BY order_date DESC;

/* ============================================================
DISTINCT
Removes duplicate values
============================================================ */

SELECT DISTINCT order_date
FROM orders
ORDER BY order_date;

SELECT DISTINCT ship_mode
FROM orders;

SELECT DISTINCT ship_mode, segment
FROM orders;

SELECT DISTINCT *
FROM orders;

/* ============================================================
WHERE CLAUSE
Used to filter records
============================================================ */

SELECT *
FROM orders
WHERE ship_mode = 'First Class';

SELECT *
FROM orders
WHERE order_date = '2020-12-08';

/* ============================================================
COMPARISON OPERATORS
====================

=   Equal
!=  Not Equal

> Greater Than
> <   Less Than
> =  Greater Than Equal
> <=  Less Than Equal

============================================================ */

SELECT order_date, quantity
FROM orders
WHERE quantity != 5
ORDER BY quantity DESC;

SELECT *
FROM orders
WHERE order_date < '2020-12-08'
ORDER BY order_date DESC;

/* ============================================================
BETWEEN
Inclusive Range Filter
============================================================ */

SELECT *
FROM orders
WHERE order_date BETWEEN '2020-12-08'
AND '2020-12-12';

SELECT *
FROM orders
WHERE quantity BETWEEN 3 AND 5;

/* ============================================================
IN OPERATOR
Alternative to multiple OR conditions
============================================================ */

SELECT *
FROM orders
WHERE quantity IN (3,4,5);

SELECT DISTINCT ship_mode
FROM orders
WHERE ship_mode IN ('First Class','Same Day');

/* ============================================================
NOT IN
Excludes specified values
============================================================ */

SELECT DISTINCT ship_mode
FROM orders
WHERE ship_mode NOT IN ('First Class','Same Day');

/* ============================================================
AND OPERATOR
Conditions must be TRUE
============================================================ */

SELECT order_date, ship_mode, segment
FROM orders
WHERE ship_mode = 'First Class'
AND segment = 'Consumer';

/* ============================================================
OR OPERATOR
Any condition can be TRUE
============================================================ */

SELECT order_date, ship_mode, segment
FROM orders
WHERE ship_mode = 'First Class'
OR segment = 'Consumer';

/*
OR  -> Usually increases rows
AND -> Usually decreases rows
*/

/* ============================================================
CALCULATED COLUMNS
============================================================ */

SELECT *,
profit / sales AS ratio,
profit * sales AS total_profit_sales,
GETDATE() AS current_time
FROM orders;

/* ============================================================
LIKE OPERATOR
Used for Pattern Matching
============================================================ */

/* Starts with Chris */

SELECT order_id, customer_name
FROM orders
WHERE customer_name LIKE 'Chris%';

/* Ends with t */

SELECT order_id, customer_name
FROM orders
WHERE customer_name LIKE '%t';

/* Contains ven */

SELECT order_id, customer_name
FROM orders
WHERE customer_name LIKE '%ven%';

/* Case-insensitive search using UPPER */

SELECT order_id,
customer_name,
UPPER(customer_name) AS name_upper
FROM orders
WHERE UPPER(customer_name) LIKE 'A%A';

/* ============================================================
WILDCARDS
=========

%  -> Zero or More Characters

_  -> Exactly One Character

============================================================ */

/* Second character must be l */

SELECT order_id, customer_name
FROM orders
WHERE customer_name LIKE '_l%';

/* First letter C, second letter any of a,l,b,o */

SELECT order_id, customer_name
FROM orders
WHERE customer_name LIKE 'C[albo]%';

/* First letter C, second letter NOT a,l,b,o */

SELECT order_id, customer_name
FROM orders
WHERE customer_name LIKE 'C[^albo]%';

/* Pattern Matching on Order ID */

SELECT order_id, customer_name
FROM orders
WHERE order_id LIKE 'CA-20[][1-2]%';

/* ============================================================
QUICK REVISION
==============

TOP          -> First N rows
DISTINCT     -> Remove duplicates
WHERE        -> Filter rows
BETWEEN      -> Range filtering
IN           -> Multiple values
NOT IN       -> Exclude values
AND          -> All conditions true
OR           -> Any condition true
LIKE         -> Pattern matching

%            -> 0 or more characters
_            -> Exactly one character

============================================================ */
