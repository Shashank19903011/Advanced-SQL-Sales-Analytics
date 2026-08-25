-- ============================================================
-- ADVANCED SQL SALES ANALYTICS
-- Section 6: Data Quality & Validation
-- ============================================================


-- 39) Find the average number of days between
-- order_date and ship_date for each region.

SELECT 
    REGION,
    ROUND(
        AVG(DATEDIFF(DAY, ORDER_DATE, SHIP_DATE)),
        2
    ) AS AVGDAYS
FROM orders_data
GROUP BY REGION;


-- 40) Find all orders where the shipping duration
-- is greater than the overall average shipping duration.

SELECT 
    ORDER_ID,
    ORDER_DATE,
    SHIP_DATE,
    DATEDIFF(
        DAY,
        ORDER_DATE,
        SHIP_DATE
    ) AS SHIPPINGDAYS
FROM orders_data
WHERE DATEDIFF(
    DAY,
    ORDER_DATE,
    SHIP_DATE
) >
(
    SELECT AVG(
        DATEDIFF(
            DAY,
            ORDER_DATE,
            SHIP_DATE
        )
    )
    FROM orders_data
);

-- ============================================================
-- ADVANCED SQL SALES ANALYTICS
-- Section 6: Data Quality & Validation
-- ============================================================


-- 49) Find rows where ship_date is earlier than order_date.

SELECT 
    ORDER_ID,
    ORDER_DATE,
    SHIP_DATE
FROM orders_data
WHERE CONVERT(DATE, SHIP_DATE) < CONVERT(DATE, ORDER_DATE);


-- 50) Find ORDER_ID values that appear more than once
-- in orders_data.

SELECT 
    ORDER_ID,
    COUNT(ORDER_ID) AS ORDERCOUNT
FROM orders_data
GROUP BY ORDER_ID
HAVING COUNT(ORDER_ID) > 1;
