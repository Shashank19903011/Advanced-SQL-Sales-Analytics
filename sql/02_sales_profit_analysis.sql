-- ============================================================
-- ADVANCED SQL SALES ANALYTICS
-- Section 2: Sales & Profit Analysis
-- ============================================================


-- 11) Find the total profit for each region,
-- but show only regions where the total profit is greater than 20,000.

SELECT 
    REGION,
    SUM(PROFIT) AS TOTALPROFIT
FROM orders_data
GROUP BY REGION
HAVING SUM(PROFIT) > 20000;

-- Result:
-- No rows returned because all regional profits
-- are below 20,000.



-- 12) Find the average profit for each category
-- and show the results from highest average profit to lowest.

SELECT 
    CATEGORY,
    ROUND(AVG(PROFIT), 2) AS AVGPROFIT
FROM orders_data
GROUP BY CATEGORY
ORDER BY AVGPROFIT DESC;

-- Result:
-- CATEGORY           AVGPROFIT
-- Technology         49.10
-- Office Supplies    12.73
-- Furniture         -68.81



-- 13) Find the product_id with the highest total sales.

SELECT TOP 1
    PRODUCT_ID,
    SUM(SALES) AS HIGHESTSALES
FROM orders_data
GROUP BY PRODUCT_ID
ORDER BY HIGHESTSALES DESC;

-- Result:
-- PRODUCT_ID          HIGHESTSALES
-- FUR-BO-10004834     3083.43



-- 14) Find the top 5 customers based on their total sales.

SELECT TOP 5
    CUSTOMER_NAME,
    SUM(SALES) AS TOTALSALES
FROM orders_data
GROUP BY CUSTOMER_NAME
ORDER BY TOTALSALES DESC;

-- Result:
-- CUSTOMER_NAME       TOTALSALES
-- Brosina Hoffman     3714.30
-- Tracy Blumstein     3348.484
-- Gene Hale            1288.46
-- Brendan Sweed        1280.988
-- Steve Nguyen         1228.953



-- 15) Find the top 3 product_id values based on total profit.

SELECT TOP 3
    PRODUCT_ID,
    SUM(PROFIT) AS TOTALPROFIT
FROM orders_data
GROUP BY PRODUCT_ID
ORDER BY TOTALPROFIT DESC;

-- Result:
-- PRODUCT_ID          TOTALPROFIT
-- TEC-PH-10002447     298.685
-- FUR-CH-10000454     219.582
-- OFF-BI-10003656     132.592



-- 16) Find the category with the highest total profit.

SELECT TOP 1
    CATEGORY,
    SUM(PROFIT) AS TOTALPROFIT
FROM orders_data
GROUP BY CATEGORY
ORDER BY TOTALPROFIT DESC;

-- Result:
-- CATEGORY       TOTALPROFIT
-- Technology     785.6683



-- 17) Find the average order value by region.

SELECT 
    REGION,
    ROUND(
        SUM(SALES) / COUNT(DISTINCT ORDER_ID),
        2
    ) AS AVGORDERVALUE
FROM orders_data
GROUP BY REGION;

-- Result:
-- REGION       AVGORDERVALUE
-- Central      247.12
-- East         752.72
-- South        432.28
-- West         528.76



-- 18) Find all product_id values where the total profit is negative.

SELECT 
    PRODUCT_ID,
    SUM(PROFIT) AS TOTALPROFIT
FROM orders_data
GROUP BY PRODUCT_ID
HAVING SUM(PROFIT) < 0;

-- Result:
-- PRODUCT_ID          TOTALPROFIT
-- FUR-BO-10002545     -46.9764
-- FUR-BO-10004834     -1665.05
-- FUR-CH-10000513     -114.391
-- FUR-CH-10001146     -15.2225
-- FUR-CH-10002774     -1.0196
-- FUR-CH-10004218     -15.147
-- FUR-FU-10000260     -5.8248
-- FUR-FU-10003194     -14.475
-- FUR-FU-10003664     -147.963
-- FUR-TA-10000577     -142.766
-- OFF-AP-10002311     -123.858
-- OFF-BI-10000474     -7.0532
-- OFF-BI-10000756     -3.816
-- OFF-BI-10001525     -5.715
-- OFF-BI-10004182     -1.9344
-- OFF-BI-10004738     -3.788
-- OFF-ST-10003656     -48.9549
-- OFF-ST-10004123     -18.196



-- 19) Find the categories where total profit is negative.

SELECT 
    CATEGORY,
    SUM(PROFIT) AS TOTALPROFIT
FROM orders_data
GROUP BY CATEGORY
HAVING SUM(PROFIT) < 0;

-- Result:
-- CATEGORY       TOTALPROFIT
-- Furniture      -1651.3438



-- 20) Find the total sales for each year.

SELECT 
    YEAR(ORDER_DATE) AS ORDERYEAR,
    SUM(SALES) AS YEARSALES
FROM orders_data
GROUP BY YEAR(ORDER_DATE)
ORDER BY ORDERYEAR;

-- Result:
-- ORDERYEAR      YEARSALES
-- 2018           6228.978
-- 2019           8645.279
-- 2020           5501.826
-- 2021           1128.436
