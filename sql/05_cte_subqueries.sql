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
