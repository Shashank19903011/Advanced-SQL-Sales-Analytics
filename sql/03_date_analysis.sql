-- ============================================================
-- ADVANCED SQL SALES ANALYTICS
-- Section 3: Date & Time Analysis
-- ============================================================


-- 21) Find the total sales for each region for each year.

SELECT 
    YEAR(ORDER_DATE) AS ORDERYEAR,
    REGION,
    SUM(SALES) AS TOTALSALES
FROM orders_data
GROUP BY 
    YEAR(ORDER_DATE),
    REGION
ORDER BY 
    ORDERYEAR,
    REGION;


-- 22) Find the total profit and total sales for each year,
-- and also calculate the profit margin percentage.

SELECT 
    YEAR(ORDER_DATE) AS ORDERYEAR,
    SUM(PROFIT) AS TOTALPROFIT,
    SUM(SALES) AS TOTALSALES,
    ROUND(
        (SUM(PROFIT) / SUM(SALES)) * 100,
        2
    ) AS TOTALPROFITPERCENTAGE
FROM orders_data
GROUP BY YEAR(ORDER_DATE)
ORDER BY ORDERYEAR;


-- 23) Find total sales for each year and month.

SELECT 
    YEAR(ORDER_DATE) AS YEARORDER,
    MONTH(ORDER_DATE) AS MONTHORDER,
    SUM(SALES) AS TOTALSALES
FROM orders_data
GROUP BY 
    YEAR(ORDER_DATE),
    MONTH(ORDER_DATE)
ORDER BY 
    YEAR(ORDER_DATE),
    MONTH(ORDER_DATE);


-- 24) Find the total profit for each year and month,
-- and sort it chronologically.

SELECT 
    YEAR(ORDER_DATE) AS YEARORDER,
    MONTH(ORDER_DATE) AS MONTHORDER,
    ROUND(SUM(PROFIT), 2) AS TOTALPROFIT
FROM orders_data
GROUP BY 
    YEAR(ORDER_DATE),
    MONTH(ORDER_DATE)
ORDER BY 
    YEAR(ORDER_DATE),
    MONTH(ORDER_DATE);


-- 25) Find monthly sales and previous month sales.

WITH CTE1 AS
(
    SELECT 
        YEAR(ORDER_DATE) AS YEARORDER,
        MONTH(ORDER_DATE) AS MONTHORDER,
        SUM(SALES) AS TOTALSALES
    FROM orders_data
    GROUP BY 
        YEAR(ORDER_DATE),
        MONTH(ORDER_DATE)
)
SELECT 
    YEARORDER,
    MONTHORDER,
    TOTALSALES,
    LAG(TOTALSALES) OVER (
        ORDER BY YEARORDER, MONTHORDER
    ) AS PREVIOUSMONTHSALES
FROM CTE1
ORDER BY 
    YEARORDER,
    MONTHORDER;


-- 26) Calculate Month-over-Month (MoM) Growth %.

WITH CTE1 AS
(
    SELECT 
        YEAR(ORDER_DATE) AS YEARORDER,
        MONTH(ORDER_DATE) AS MONTHORDER,
        SUM(SALES) AS TOTALSALES
    FROM orders_data
    GROUP BY 
        YEAR(ORDER_DATE),
        MONTH(ORDER_DATE)
),
CTE2 AS
(
    SELECT 
        YEARORDER,
        MONTHORDER,
        TOTALSALES,
        LAG(TOTALSALES) OVER (
            ORDER BY YEARORDER, MONTHORDER
        ) AS PREVIOUSMONTHSALES
    FROM CTE1
)
SELECT 
    YEARORDER,
    MONTHORDER,
    TOTALSALES,
    PREVIOUSMONTHSALES,
    ROUND(
        (TOTALSALES - PREVIOUSMONTHSALES)
        / PREVIOUSMONTHSALES * 100,
        2
    ) AS MOMGROWTH
FROM CTE2
ORDER BY 
    YEARORDER,
    MONTHORDER;


-- 27) Calculate Year-over-Year (YoY) Growth %.

WITH CTE1 AS
(
    SELECT 
        YEAR(ORDER_DATE) AS YEARORDER,
        SUM(SALES) AS TOTALSALES
    FROM orders_data
    GROUP BY YEAR(ORDER_DATE)
),
CTE2 AS
(
    SELECT 
        YEARORDER,
        TOTALSALES,
        LAG(TOTALSALES) OVER (
            ORDER BY YEARORDER
        ) AS PREVIOUSYEARSALES
    FROM CTE1
)
SELECT 
    YEARORDER,
    TOTALSALES,
    PREVIOUSYEARSALES,
    ROUND(
        (TOTALSALES - PREVIOUSYEARSALES)
        / PREVIOUSYEARSALES * 100,
        2
    ) AS YOYGROWTH
FROM CTE2
ORDER BY YEARORDER;


-- 28) Find cumulative/running sales by year.

WITH CTE1 AS
(
    SELECT 
        YEAR(ORDER_DATE) AS YEARORDER,
        SUM(SALES) AS TOTALSALES
    FROM orders_data
    GROUP BY YEAR(ORDER_DATE)
),
CTE2 AS
(
    SELECT 
        YEARORDER,
        TOTALSALES,
        SUM(TOTALSALES) OVER (
            ORDER BY YEARORDER
        ) AS CUMULATIVETOTAL
    FROM CTE1
)
SELECT 
    YEARORDER,
    TOTALSALES,
    CUMULATIVETOTAL
FROM CTE2
ORDER BY YEARORDER;
