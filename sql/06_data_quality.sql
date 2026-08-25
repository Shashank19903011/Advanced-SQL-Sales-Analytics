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
