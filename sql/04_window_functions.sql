
-- ============================================================
-- ADVANCED SQL SALES ANALYTICS
-- Section 4: Window Functions
-- ============================================================


-- 29) Find the rank of each customer based on total sales,
-- where the highest-selling customer gets Rank 1.

WITH CTE1 AS
(
    SELECT 
        CUSTOMER_NAME,
        SUM(SALES) AS TOTALSALES
    FROM orders_data
    GROUP BY CUSTOMER_NAME
)
SELECT 
    CUSTOMER_NAME,
    TOTALSALES,
    RANK() OVER (
        ORDER BY TOTALSALES DESC
    ) AS RANKING
FROM CTE1
ORDER BY RANKING;


-- 30) Find the top 3 customers by sales within each region.

WITH CTE1 AS
(
    SELECT 
        CUSTOMER_NAME,
        REGION,
        SUM(SALES) AS TOTALSALES
    FROM orders_data
    GROUP BY 
        CUSTOMER_NAME,
        REGION
),
CTE2 AS
(
    SELECT 
        CUSTOMER_NAME,
        REGION,
        TOTALSALES,
        RANK() OVER (
            PARTITION BY REGION
            ORDER BY TOTALSALES DESC
        ) AS RANKING
    FROM CTE1
)
SELECT 
    CUSTOMER_NAME,
    REGION,
    TOTALSALES,
    RANKING
FROM CTE2
WHERE RANKING <= 3
ORDER BY 
    REGION,
    RANKING;


-- 31) Find the top 3 products based on total sales
-- within each category.

WITH CTE1 AS
(
    SELECT 
        PRODUCT_ID,
        CATEGORY,
        SUM(SALES) AS TOTALSALES
    FROM orders_data
    GROUP BY 
        PRODUCT_ID,
        CATEGORY
),
CTE2 AS
(
    SELECT 
        PRODUCT_ID,
        CATEGORY,
        TOTALSALES,
        RANK() OVER (
            PARTITION BY CATEGORY
            ORDER BY TOTALSALES DESC
        ) AS RANKING
    FROM CTE1
)
SELECT 
    PRODUCT_ID,
    CATEGORY,
    TOTALSALES,
    RANKING
FROM CTE2
WHERE RANKING <= 3
ORDER BY 
    CATEGORY,
    RANKING;


-- 32) Find the top 3 products based on total profit
-- within each region.

WITH CTE1 AS
(
    SELECT 
        PRODUCT_ID,
        REGION,
        SUM(PROFIT) AS TOTALPROFIT
    FROM orders_data
    GROUP BY 
        PRODUCT_ID,
        REGION
),
CTE2 AS
(
    SELECT 
        PRODUCT_ID,
        REGION,
        TOTALPROFIT,
        RANK() OVER (
            PARTITION BY REGION
            ORDER BY TOTALPROFIT DESC
        ) AS RANKING
    FROM CTE1
)
SELECT 
    PRODUCT_ID,
    REGION,
    TOTALPROFIT,
    RANKING
FROM CTE2
WHERE RANKING <= 3
ORDER BY 
    REGION,
    RANKING;
