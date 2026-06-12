CREATE TABLE amazon_orders (
    order_id INTEGER,
    order_date DATE,
    product_name VARCHAR(100),
    total_price DECIMAL(6,2),
    payment_method VARCHAR(20)
);

---------------------------------------------------------------------------
-- 1. Change data type of a column
ALTER TABLE amazon_orders ALTER COLUMN order_date DATETIME; 

-- 2. Shrink a VARCHAR column (Only works if existing data fits the new size)
ALTER TABLE amazon_orders ALTER COLUMN product_name VARCHAR(20); 

-- 3. Add a new column to the existing table
ALTER TABLE amazon_orders ADD username VARCHAR(20);
ALTER TABLE amazon_orders ADD category VARCHAR(20);

-- 4. Delete (Drop) a column from the existing table
ALTER TABLE amazon_orders DROP COLUMN category;

---------------------------------------------------------------------------

-- Insert a complete row (values must match the column order exactly)
INSERT INTO amazon_orders VALUES (5, '2022-10-01 12:05:12', 'Shoes', 132.5, 'UPI');

-- Insert a row with a NULL value (NULL means "no value" or "unknown")
INSERT INTO amazon_orders VALUES (6, '2022-10-01 12:05:12', NULL, 132.5, 'UPI');

-- ⚠️ Note: 'null' in quotes is just a regular text word, not an actual empty value.
INSERT INTO amazon_orders VALUES (7, '2022-10-01 12:05:12', 'null', 132.5, 'UPI');


---------------------------------------------------------------------------

DROP TABLE IF EXISTS a_orders; -- Removes the table if it already exists

CREATE TABLE a_orders (
    order_id INTEGER,
    order_date DATE,
    product_name VARCHAR(100),
    total_price DECIMAL(6,2),
    
    -- CHECK Constraint: Ensures only specific values are allowed
    payment_method VARCHAR(20) CHECK (payment_method IN ('UPI', 'CREDIT CARD')) DEFAULT 'UPI',
    
    -- CHECK Constraint: Ensures the number is 20 or less
    discount INTEGER CHECK (discount <= 20),
    
    -- DEFAULT Constraint: If no value is provided, it uses 'Mens Wear'
    category VARCHAR(20) DEFAULT 'Mens Wear',
    
    -- PRIMARY KEY Constraint: Ensures the combination of order_id and product_name is UNIQUE and NOT NULL
    PRIMARY KEY (order_id, product_name)
);


---------------------------------------------------------------------------

-- Deletes ONLY the rows where the product is 'jeans'
DELETE FROM a_orders WHERE product_name = 'jeans';

---------------------------------------------------------------------------
-- 1. Updates EVERY row in the table (Dangerous if not intended)
UPDATE a_orders SET discount = 10;

-- 2. Updates ONLY the row where order_id is 2 (Safe and recommended)
UPDATE a_orders SET discount = 10 WHERE order_id = 2;

-- 3. Updates MULTIPLE columns at once for a specific condition
UPDATE a_orders 
SET product_name = 'jeans2', payment_method = 'CREDIT CARD' 
WHERE product_name = 'jeans';