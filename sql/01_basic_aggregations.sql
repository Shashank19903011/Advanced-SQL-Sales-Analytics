-- ============================================================
-- ADVANCED SQL SALES ANALYTICS
-- Section 1: Basic Aggregations
-- ============================================================


-- 1) Find the total sales from the entire dataset.

SELECT 
    SUM(SALES) AS TOTALSALES
FROM orders_data;

-- Result:
-- TOTALSALES
-- 21504.519


-- 2) Find the total profit from the entire dataset.

SELECT 
    SUM(PROFIT) AS TOTALPROFIT
FROM orders_data;

-- Result:
-- TOTALPROFIT
-- 101.889


-- 3) Find the total quantity of products sold.

SELECT 
    SUM(QUANTITY) AS TOTALQUANTITY
FROM orders_data;

-- Result:
-- TOTALQUANTITY
-- 374


-- 4) Find the total number of unique orders in the dataset.

SELECT 
    COUNT(DISTINCT ORDER_ID) AS TOTALORDERS
FROM orders_data;

-- Result:
-- TOTALORDERS
-- 50


-- 5) Find the average sales value per unique order.

SELECT 
    SUM(SALES) / COUNT(DISTINCT ORDER_ID) AS AVERAGE_SALES_ORDER
FROM orders_data;

-- Result:
-- AVERAGE_SALES_ORDER
-- 430.09038


-- 6) Find the total sales for each region.

SELECT 
    REGION,
    SUM(SALES) AS REGIONSALES
FROM orders_data
GROUP BY REGION;

-- Result:
-- REGION     REGIONSALES
-- Central    4942.356
-- East       5269.052
-- South      3890.497
-- West       7402.614


-- 7) Find the total profit for each product category.

SELECT 
    CATEGORY,
    SUM(PROFIT) AS TOTALPROFIT
FROM orders_data
GROUP BY CATEGORY;

-- Result:
-- CATEGORY          TOTALPROFIT
-- Furniture         -1651.3438
-- Office Supplies    763.7865
-- Technology         785.6683


-- 8) Find the total quantity sold for each category.

SELECT 
    CATEGORY,
    SUM(QUANTITY) AS TOTALQUANTITY
FROM orders_data
GROUP BY CATEGORY;

-- Result:
-- CATEGORY          TOTALQUANTITY
-- Furniture         99
-- Office Supplies   221
-- Technology        54


-- 9) Find the total sales for each category
-- and sort the result from highest sales to lowest sales.

SELECT 
    CATEGORY,
    SUM(SALES) AS TOTALSALES
FROM orders_data
GROUP BY CATEGORY
ORDER BY TOTALSALES DESC;

-- Result:
-- CATEGORY          TOTALSALES
-- Furniture         11083.775
-- Office Supplies    5233.990
-- Technology         5186.754


-- 10) Find the total sales for each region,
-- but display only regions where total sales are greater than 100,000.

SELECT 
    REGION,
    SUM(SALES) AS TOTALSALES
FROM orders_data
GROUP BY REGION
HAVING SUM(SALES) > 100000;

-- Result:
-- No rows returned because all regional sales
-- are below 100,000.
