-- Drop the table if it already exists to start fresh
DROP TABLE IF EXISTS blinkit_grocery_sales;

-- Create the unique base table
CREATE TABLE blinkit_grocery_sales (
    item_id INT,
    item_name VARCHAR(100),
    order_date DATE,
    price_per_unit DECIMAL(10, 2),
    quantity_ordered INT,
    total_bill DECIMAL(10, 2),
    -- Constraint: Only accepts specific modern payment modes
    payment_mode VARCHAR(30) CHECK (payment_mode IN ('UPI', 'CREDIT CARD', 'CASH ON DELIVERY')) DEFAULT 'UPI',
    -- Constraint: Sets a standard section if left blank
    store_section VARCHAR(50) DEFAULT 'General Store',
    -- Composite Primary Key: Ensures an item isn't listed twice in the exact same order slot
    PRIMARY KEY (item_id, order_date)
);

-- Insert highly realistic grocery data to test your queries
INSERT INTO blinkit_grocery_sales (item_id, item_name, order_date, price_per_unit, quantity_ordered, total_bill, payment_mode, store_section)
VALUES 
(501, 'Amul Butter 500g', '2026-06-10', 275.00, 2, 550.00, 'UPI', 'Dairy & Eggs'),
(502, 'Brown Bread',       '2026-06-11', 50.00,  1, 50.00,  'CASH ON DELIVERY', 'Bakery'),
(503, 'Diet Coke Can',    '2026-06-10',  40.00,  5, 200.00, 'CREDIT CARD', 'Beverages'),
(504, 'Basmati Rice 5kg',  '2026-06-12', 650.00, 1, 650.00, 'UPI', 'Atta & Rice'),
(505, 'Potato Chips XL',   '2026-06-14', 60.00,  3, 180.00, 'UPI', 'Snacks');


-- Category 1: ALTER TABLE Operations

-- 1. Write a query to change the data type of quantity_ordered from INT to FLOAT in case partial weights are allowed.
ALTER TABLE blinkit_grocery_sales ALTER COLUMN quantity_ordered FLOAT;

-- 2. Add a new text column named delivery_partner (VARCHAR(50)) to the table.
ALTER TABLE blinkit_grocery_sales ADD delivery_parrtner VARCHAR(50);

-- 3. What will happen if you try to shrink item_name to VARCHAR(5) using an ALTER statement right now? Why?
--ANS: If any existing item_name value is longer than 5 characters, the ALTER statement may fail or truncate data. Otherwise, it will succeed and limit the column to 5 characters

-- 4. Write a query to permanently delete the column delivery_partner from your table.
ALTER TABLE blinkit_grocery_sales DROP COLUMN delivery_partner;

--5. Add a new column named customer_rating using the INT data type.
ALTER TABLE blinkit_grocery_sales ADD customer_rating INT(5);

-- 6. Change the data type of the store_section column to VARCHAR(100).
ALTER TABLE blinkit_grocery_sales ALTER COLUMN store_section VARCHAR(100);

-- 7. Write a query to add a column named delivery_slot_hours (INT) to track delivery timelines.
ALTER TABLE blinkit_grocery_sales ADD delivery_slot_hours INT;

-- 8. Drop the delivery_slot_hours column you just added.
ALTER TABLE blinkit_grocery_sales DROP COLUMN delivery_slot_hours;

-- 9. If you add a brand new column named is_organic (VARCHAR(5)) right now, what value will the 5 existing rows automatically display in that column?
--ANS: Existing rows will automatically contain NULL values in the new is_organic column.
ALTER TABLE blinkit_grocery_sales ADD is_organic VARCHAR(5);

-- 10. Can you use ALTER TABLE to change a column's name in SQL Server directly without using a special built-in procedure?
--ANS: No. SQL Server cannot rename a column using ALTER TABLE alone. We must use the sp_rename stored procedure to change a column name.


-- Category 2: INSERT & The Behavior of NULL

--11. Insert a new grocery row where item_name is left completely blank using a true database NULL.
INSERT INTO blinkit_grocery_sales (item_name) VALUES(NULL);

-- 12. Write an INSERT statement that explicitly inserts the literal text string 'NULL' (with quotes) into the item_name column.
INSERT INTO blinkit_grocery_sales (item_id) VALUES('NULL');

-- 13. If you run an INSERT statement and intentionally omit the payment_mode and store_section columns, what values will those columns hold for the new row?
-- ANSWER: They will automatically take their DEFAULT values ('UPI' and 'General Store').

-- 14. Write a query to insert an item with item_id = 506 on '2026-06-15' without providing any values for price_per_unit, quantity_ordered, or total_bill.
INSERT INTO blinkit_grocery_sales (item_id , order_date) VALUES(506,'2026-06-15' );

-- 15. What error will you receive if you try to execute an INSERT statement where the order_date is completely omitted or passed as a NULL value?
-- ANSWER: You will receive a "Cannot insert the value NULL into column 'order_date'" error.
-- WHY: Because 'order_date' is part of the PRIMARY KEY, and Primary Keys strictly forbid NULL values.


-- 16. Write a single query that inserts two different grocery rows at the exact same time into the table.
INSERT INTO blinkit_grocery_sales
VALUES 
(506, 'Fresh Paneer 200g', '2026-06-15', 90.00,  2, 180.00, 'UPI', 'Dairy & Eggs'),
(507, 'Coca Cola 1.25L',   '2026-06-15', 70.00,  1, 70.00,  'CREDIT CARD', 'Beverages');

-- 17. If you try to insert an item name that is 110 characters long into item_name, what specific issue or error will the database raise?
-- ANSWER: receive a "String or binary data would be truncated" error (or "Data too long for column" depending on the SQL flavor).
-- WHY: Because the 'item_name' column is explicitly restricted to a maximum length of 100 characters (VARCHAR(100)). The database blocks the insert to prevent cutting off your data.

-- 18. Write an INSERT statement where you explicitly pass the keyword DEFAULT for both payment_mode and store_section instead of typing out the actual words.
INSERT INTO blinkit_grocery_sales
VALUES (508, 'Greek Yogurt', '2026-06-16', 60.00, 2, 120.00, DEFAULT, DEFAULT);

-- 19. If you run INSERT INTO blinkit_grocery_sales VALUES (507, 'Milk', '2026-06-16', 30.00, 2, 60.00);, why will this query fail even if the data types match up?
-- ANSWER: The query will fail with a "Column name or number of supplied values does not match table definition" error.
-- WHY: Your table has 8 columns in total. When you do not specify column names after the table name, SQL expects you to provide values for all 8 columns. You only provided 6 values.

-- 20. Write a query to verify which rows in your table have a truly missing (NULL) value in the item_name column.
 SELECT * FROM blinkit_grocery_sales WHERE item_name IS NULL;


--  Category 3: Constraints (CHECK, DEFAULT, PRIMARY KEY)

-- 21. What happens to the database transaction if you try to insert a row where the payment_mode is written as 'DEBIT CARD'?
-- ANSWER: The database transaction will fail completely and roll back due to a CHECK constraint violation error.
-- WHY: Because your table schema explicitly restricts 'payment_mode' to ('UPI', 'CREDIT CARD', 'CASH ON DELIVERY'). Since 'DEBIT CARD' is not on that list, the database blocks the entry to maintain data purity.

-- 22. The payment_mode constraint accepts 'CREDIT CARD' in all capital letters. Will it accept lowercase 'credit card'? Why or why not?
-- ANSWER: It depends on your database collation, but in standard Microsoft SQL Server, it WILL accept lowercase 'credit card' because the database is case-insensitive by default.
-- WHY: SQL Server treats 'credit card' and 'CREDIT CARD' as the same value unless you explicitly configure the table or database to use a Case-Sensitive (CS) collation.

-- 23. Explain why the database will reject a new row with item_id = 501 and order_date = '2026-06-10', even if the item_name is changed to 'Amul Cheese'.
-- ANSWER: The database will throw a "Violation of PRIMARY KEY constraint" error because the pair (501, '2026-06-10') already exists in the table.
-- WHY: My table uses a composite Primary Key made of (item_id, order_date). Changing the 'item_name' does not matter because the database only checks the key columns to ensure uniqueness.

-- 24. Can you insert two completely identical items (item_id = 501, same name, same price) if they were ordered on two entirely different dates?
-- ANSWER: Yes, you can absolutely insert them.
-- WHY: Because your composite Primary Key checks the combination of (item_id, order_date). Since the dates are entirely different, the unique combination rule is satisfied perfectly.


-- 25. Write an ALTER TABLE statement syntax that would add a new CHECK constraint to ensure quantity_ordered is always greater than 0.
ALTER TABLE blinkit_grocery_sales ADD CONSTRAINT chk_quantity CHECK (quantity_ordered > 0);

-- 26. If a table has a composite Primary Key made of two columns, how many of those columns are allowed to contain NULL values?
-- ANSWER: Zero (0) columns. 
-- WHY: A fundamental rule of Primary Keys is that no part of the key can ever contain a NULL value, even if it is a composite key made of multiple columns.

-- 27. How does a DEFAULT constraint behave if you explicitly type out and pass NULL for that column during an INSERT?
-- ANSWER: The database will override the default rule and explicitly insert the NULL value into that column.
-- WHY: A DEFAULT constraint only kicks in if you completely leave the column out of your query, or if you use the explicit keyword 'DEFAULT'.

-- 28. Write a statement to add a CHECK constraint to the customer_rating column ensuring the rating is only between 1 and 5.
ALTER TABLE blinkit_grocery_sales ADD CONSTRAINT chk_rating CHECK (customer_rating BETWEEN 1 AND 5);

-- 29. Look at your schema definition. Is it possible for two different orders to have the exact same item_id if they happen on the same day?
-- ANSWER: No, it is not possible.
-- WHY: Because your composite Primary Key is (item_id, order_date). The database treats each day as a single slot per item, meaning that specific item can only appear once per day.

-- 30. If you decide to drop the primary key constraint later, will the database automatically allow duplicate values in those columns?
-- ANSWER: Yes, it will.
-- WHY: Once the Primary Key constraint is dropped, the unique safeguard is completely removed, allowing duplicate entries and NULL values to enter those columns freely.



--Category 4: UPDATE & Row Modifications

-- 31. Write an UPDATE query to change the store_section of every single row in the table to 'Gourmet Corner'.
UPDATE blinkit_grocery_sales SET store_section = 'Gourmet Corner';

-- 32. Why is the query you just wrote in Question 31 considered incredibly high-risk in a production environment?
-- ANSWER: Because it completely lacks a WHERE clause. This forces the database to overwrite the data across every single row in the table, destroying your original historical data.

-- 33. Write a safe UPDATE query to change the payment_mode to 'CREDIT CARD' only for the order where item_id = 502 on '2026-06-11'.
UPDATE blinkit_grocery_sales SET payment_mode = 'CREDIT CARD' WHERE item_id = 502 AND order_date = '2026-06-11';

-- 34. Write a query to change both the quantity_ordered to 4 and the total_bill to 240.00 for the 'Potato Chips XL' row.
UPDATE blinkit_grocery_sales SET quantity_ordered = 4, total_bill = 240.00 WHERE item_name = 'Potato Chips XL';

-- 35. How would you write an update query to change the store_section column to 'Organic Dairy' for all items currently located in the 'Dairy & Eggs' section?
UPDATE blinkit_grocery_sales SET store_section = 'Organic Dairy' WHERE store_section = 'Dairy & Eggs';

-- 36. Write a query to apply a 10% price drop to the price_per_unit column for all items belonging to the 'Beverages' section.
UPDATE blinkit_grocery_sales SET price_per_unit = price_per_unit * 0.90 WHERE store_section = 'Beverages';



--Category 5: DELETE & Row Removal


-- 37. Write a query to delete only the row representing 'Diet Coke Can' using its specific compound primary key values.
DELETE FROM blinkit_grocery_sales WHERE item_id = 503 AND order_date = '2026-06-10';

-- 38. What is the fundamental operational difference between running DELETE FROM blinkit_grocery_sales; and running DROP TABLE blinkit_grocery_sales;?
-- ANSWER: DELETE empties all the data rows from the table while leaving the empty table structure intact. DROP completely deletes the entire table container and structure from the database.

-- 39. Write a statement to delete all orders from the table where the total_bill is less than or equal to 50.00.
DELETE FROM blinkit_grocery_sales WHERE total_bill <= 50.00;

-- 40. Write a statement to delete rows where the item name is the literal text string 'null', while leaving actual database NULL values completely untouched.
DELETE FROM blinkit_grocery_sales WHERE item_name = 'null';

