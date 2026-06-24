-- ==========================================
-- 1. FILTERING NULL VALUES
-- ==========================================
SELECT * FROM orders WHERE city IS NULL;
SELECT * FROM orders WHERE city IS NOT NULL;


-- ==========================================
-- 2. BASIC AGGREGATIONS (No Grouping)
-- ==========================================
SELECT 
    COUNT(*) AS cnt,
    SUM(sales) AS total_sales,
    MAX(sales) AS max_sales,
    MIN(profit) AS min_profit,
    AVG(profit) AS avg_profit
FROM orders;


-- ==========================================
-- 3. GROUP BY CLAUSE
-- ==========================================
-- Correct: All non-aggregated columns are in GROUP BY
SELECT 
    region, 
    COUNT(*) AS cnt,
    SUM(sales) AS total_sales,
    MAX(sales) AS max_sales,
    MIN(profit) AS min_profit,
    AVG(profit) AS avg_profit
FROM orders
GROUP BY region;

-- ? ERROR EXAMPLE (Commented out so it doesn't break your code):
-- SELECT region, category, SUM(sales) AS total_sales FROM orders GROUP BY region;


-- ==========================================
-- 4. WHERE vs HAVING & ORDER OF EXECUTION
-- ==========================================
-- Filters rows (profit > 50) -> Groups -> Sorts -> Takes Top 2
SELECT TOP 2 region, SUM(sales) AS total_sales
FROM orders
WHERE profit > 50
GROUP BY region
ORDER BY total_sales DESC;

-- Groups -> Calculates Sum -> Filters groups (sum > 100k) -> Sorts
SELECT sub_category, SUM(sales) AS total_sales
FROM orders
GROUP BY sub_category
HAVING SUM(sales) > 100000
ORDER BY total_sales DESC;

-- Combining WHERE (pre-filter) and HAVING (post-filter)
SELECT TOP 5 sub_category, SUM(sales) AS total_sales
FROM orders
WHERE profit > 50
GROUP BY sub_category
HAVING SUM(sales) > 100000
ORDER BY total_sales DESC;


-- ==========================================
-- 5. DATES: HAVING vs WHERE
-- ==========================================
-- HAVING: Groups everything, then keeps groups where the LATEST order is > 2020
SELECT 
    sub_category, 
    MIN(order_date) AS first_order, 
    SUM(sales) AS total_sales
FROM orders
GROUP BY sub_category
HAVING MAX(order_date) > '2020-01-01'
ORDER BY total_sales DESC;

-- WHERE: Throws away old orders FIRST, then groups the remaining recent orders
SELECT 
    sub_category, 
    SUM(sales) AS total_sales
FROM orders
WHERE order_date > '2020-01-01'
GROUP BY sub_category
ORDER BY total_sales DESC;


-- ==========================================
-- 6. COUNT VARIATIONS & THE AVG TRAP
-- ==========================================
SELECT 
    COUNT(DISTINCT region) AS unique_regions,
    COUNT(*) AS total_rows,
    COUNT(city) AS non_null_cities,
    SUM(sales) AS total_sales
FROM orders;

-- Demonstrating the difference between AVG() and manual division
SELECT 
    region, 
    AVG(sales) AS true_avg_sales,           -- Ignores NULLs in the 'sales' column
    SUM(sales) / COUNT(region) AS manual_avg -- Divides by the count of the 'region' column
FROM orders
GROUP BY region;