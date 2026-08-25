-- ============================================================
-- ADVANCED SQL SALES ANALYTICS
-- Section 5: CTEs & Subqueries
-- ============================================================


-- 33) Find customers whose total sales are greater
-- than the average customer sales.

SELECT 
    CUSTOMER_NAME,
    SUM(SALES) AS TOTALSALES
FROM orders_data
GROUP BY CUSTOMER_NAME
HAVING SUM(SALES) >
(
    SELECT AVG(TOTALSALES)
    FROM
    (
        SELECT 
            CUSTOMER_NAME,
            SUM(SALES) AS TOTALSALES
        FROM orders_data
        GROUP BY CUSTOMER_NAME
    ) AS C
);


-- 35) Find the customer with the second-highest total sales.

WITH CTE1 AS
(
    SELECT 
        CUSTOMER_NAME,
        SUM(SALES) AS TOTALSALES
    FROM orders_data
    GROUP BY CUSTOMER_NAME
),
CTE2 AS
(
    SELECT 
        CUSTOMER_NAME,
        TOTALSALES,
        RANK() OVER (
            ORDER BY TOTALSALES DESC
        ) AS RANKING
    FROM CTE1
)
SELECT 
    CUSTOMER_NAME,
    TOTALSALES
FROM CTE2
WHERE RANKING = 2;


-- 36) Find the third-highest customer based on total sales.

WITH CTE1 AS
(
    SELECT 
        CUSTOMER_NAME,
        SUM(SALES) AS TOTALSALES
    FROM orders_data
    GROUP BY CUSTOMER_NAME
),
CTE2 AS
(
    SELECT 
        CUSTOMER_NAME,
        TOTALSALES,
        DENSE_RANK() OVER (
            ORDER BY TOTALSALES DESC
        ) AS RANKING
    FROM CTE1
)
SELECT 
    CUSTOMER_NAME,
    TOTALSALES
FROM CTE2
WHERE RANKING = 3;


-- 37) Find the city with the highest total sales.

WITH CTE1 AS
(
    SELECT 
        CITY,
        SUM(SALES) AS TOTALSALES
    FROM orders_data
    GROUP BY CITY
),
CTE2 AS
(
    SELECT 
        CITY,
        TOTALSALES,
        DENSE_RANK() OVER (
            ORDER BY TOTALSALES DESC
        ) AS RANKING
    FROM CTE1
)
SELECT 
    CITY,
    TOTALSALES,
    RANKING
FROM CTE2
WHERE RANKING = 1;


-- 38) Find the city with the highest total sales
-- within each region.

WITH CTE1 AS
(
    SELECT 
        REGION,
        CITY,
        SUM(SALES) AS TOTALSALES
    FROM orders_data
    GROUP BY 
        REGION,
        CITY
),
CTE2 AS
(
    SELECT 
        REGION,
        CITY,
        TOTALSALES,
        DENSE_RANK() OVER (
            PARTITION BY REGION
            ORDER BY TOTALSALES DESC
        ) AS RANKING
    FROM CTE1
)
SELECT 
    REGION,
    CITY,
    TOTALSALES,
    RANKING
FROM CTE2
WHERE RANKING = 1;


-- ============================================================
-- ADVANCED SQL SALES ANALYTICS
-- Section 5: CTEs, Subqueries & Business Analysis
-- ============================================================


-- 41) Find customers who have placed more than 10 unique orders.

SELECT 
    CUSTOMER_NAME,
    COUNT(DISTINCT ORDER_ID) AS DISTINCTCOUNT
FROM orders_data
GROUP BY CUSTOMER_NAME
HAVING COUNT(DISTINCT ORDER_ID) > 10;


-- 42) Find customers whose total profit is greater than 0.

SELECT 
    CUSTOMER_NAME,
    SUM(PROFIT) AS TOTALPROFIT
FROM orders_data
GROUP BY CUSTOMER_NAME
HAVING SUM(PROFIT) > 0;


-- 43) Find customers who have:
-- Total Sales > 50,000
-- Total Profit > 5,000

SELECT 
    CUSTOMER_NAME,
    SUM(SALES) AS TOTALSALES,
    SUM(PROFIT) AS TOTALPROFIT
FROM orders_data
GROUP BY CUSTOMER_NAME
HAVING 
    SUM(SALES) > 50000
    AND SUM(PROFIT) > 5000;


-- 44) Find customers who purchased from
-- more than 2 different categories.

SELECT 
    CUSTOMER_NAME,
    COUNT(DISTINCT CATEGORY) AS UNIQUECATEGORY
FROM orders_data
GROUP BY CUSTOMER_NAME
HAVING COUNT(DISTINCT CATEGORY) > 2;


-- 45) Find the profit margin percentage for each customer.

WITH CTE1 AS
(
    SELECT 
        CUSTOMER_NAME,
        SUM(SALES) AS TOTALSALES,
        SUM(PROFIT) AS TOTALPROFIT
    FROM orders_data
    GROUP BY CUSTOMER_NAME
),
CTE2 AS
(
    SELECT 
        CUSTOMER_NAME,
        TOTALSALES,
        TOTALPROFIT,
        ROUND(
            (TOTALPROFIT / TOTALSALES) * 100,
            2
        ) AS PROFITMARGIN
    FROM CTE1
)
SELECT *
FROM CTE2;


-- 46) Find products where:
-- Total Sales > 10,000
-- Total Profit < 0

SELECT 
    PRODUCT_ID,
    SUM(SALES) AS TOTALSALES,
    SUM(PROFIT) AS TOTALPROFIT
FROM orders_data
GROUP BY PRODUCT_ID
HAVING 
    SUM(SALES) > 10000
    AND SUM(PROFIT) < 0;


-- 47) Find the product with the highest total profit
-- within each category.

WITH CTE1 AS
(
    SELECT 
        PRODUCT_ID,
        CATEGORY,
        SUM(PROFIT) AS TOTALPROFIT
    FROM orders_data
    GROUP BY 
        PRODUCT_ID,
        CATEGORY
),
CTE2 AS
(
    SELECT 
        CATEGORY,
        PRODUCT_ID,
        TOTALPROFIT,
        DENSE_RANK() OVER (
            PARTITION BY CATEGORY
            ORDER BY TOTALPROFIT DESC
        ) AS RANKING
    FROM CTE1
)
SELECT *
FROM CTE2
WHERE RANKING = 1;


-- 48) Find the customer with the highest profit margin.

WITH CTE1 AS
(
    SELECT 
        CUSTOMER_NAME,
        SUM(PROFIT) AS TOTALPROFIT,
        SUM(SALES) AS TOTALSALES
    FROM orders_data
    GROUP BY CUSTOMER_NAME
),
CTE2 AS
(
    SELECT 
        CUSTOMER_NAME,
        TOTALSALES,
        TOTALPROFIT,
        ROUND(
            (TOTALPROFIT / TOTALSALES) * 100,
            2
        ) AS PROFITMARGIN
    FROM CTE1
),
CTE3 AS
(
    SELECT 
        CUSTOMER_NAME,
        TOTALSALES,
        TOTALPROFIT,
        PROFITMARGIN,
        DENSE_RANK() OVER (
            ORDER BY PROFITMARGIN DESC
        ) AS RANKING
    FROM CTE2
)
SELECT *
FROM CTE3
WHERE RANKING = 1;
