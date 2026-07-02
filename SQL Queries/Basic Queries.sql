-- ============================================================
-- BLINKIT BUSINESS ANALYTICS PROJECT
-- Author : M Jeevan Reddy
-- Database : Blinkit
-- SQL Dialect : MySQL 8.0
-- ============================================================

-- ============================================================
-- BASIC BUSINESS QUERIES
-- ============================================================

---------------------------------------------------------------
-- Query 1 : Total Customers
---------------------------------------------------------------

SELECT
    COUNT(*) AS Total_Customers
FROM customers;


---------------------------------------------------------------
-- Query 2 : Total Orders
---------------------------------------------------------------

SELECT
    COUNT(*) AS Total_Orders
FROM orders;


---------------------------------------------------------------
-- Query 3 : Total Revenue
---------------------------------------------------------------

SELECT
    ROUND(SUM(order_total),2) AS Total_Revenue
FROM orders;


---------------------------------------------------------------
-- Query 4 : Average Order Value
---------------------------------------------------------------

SELECT
    ROUND(AVG(order_total),2) AS Average_Order_Value
FROM orders;


---------------------------------------------------------------
-- Query 5 : Highest Order Value
---------------------------------------------------------------

SELECT
    MAX(order_total) AS Highest_Order
FROM orders;


---------------------------------------------------------------
-- Query 6 : Lowest Order Value
---------------------------------------------------------------

SELECT
    MIN(order_total) AS Lowest_Order
FROM orders;


---------------------------------------------------------------
-- Query 7 : Revenue by Payment Method
---------------------------------------------------------------

SELECT
    payment_method,
    ROUND(SUM(order_total),2) AS Revenue
FROM orders
GROUP BY payment_method
ORDER BY Revenue DESC;


---------------------------------------------------------------
-- Query 8 : Orders by Payment Method
---------------------------------------------------------------

SELECT
    payment_method,
    COUNT(*) AS Total_Orders
FROM orders
GROUP BY payment_method
ORDER BY Total_Orders DESC;


---------------------------------------------------------------
-- Query 9 : Orders by Delivery Status
---------------------------------------------------------------

SELECT
    delivery_status,
    COUNT(*) AS Orders
FROM orders
GROUP BY delivery_status
ORDER BY Orders DESC;


---------------------------------------------------------------
-- Query 10 : Monthly Orders
---------------------------------------------------------------

SELECT
    order_month,
    COUNT(*) AS Total_Orders
FROM orders
GROUP BY order_month
ORDER BY Total_Orders DESC;


---------------------------------------------------------------
-- Query 11 : Yearly Orders
---------------------------------------------------------------

SELECT
    order_year,
    COUNT(*) AS Orders
FROM orders
GROUP BY order_year;


---------------------------------------------------------------
-- Query 12 : Orders by Weekday
---------------------------------------------------------------

SELECT
    weekday,
    COUNT(*) AS Orders
FROM orders
GROUP BY weekday
ORDER BY Orders DESC;


---------------------------------------------------------------
-- Query 13 : Average Delivery Time
---------------------------------------------------------------

SELECT
    ROUND(AVG(delivery_time_minutes),2) AS Average_Delivery_Time
FROM delivery;


---------------------------------------------------------------
-- Query 14 : Average Distance Covered
---------------------------------------------------------------

SELECT
    ROUND(AVG(distance_km),2) AS Average_Distance
FROM delivery;


---------------------------------------------------------------
-- Query 15 : Delivery Status Distribution
---------------------------------------------------------------

SELECT
    delivery_status,
    COUNT(*) AS Orders
FROM delivery
GROUP BY delivery_status;


---------------------------------------------------------------
-- Query 16 : Average Customer Rating
---------------------------------------------------------------

SELECT
    ROUND(AVG(rating),2) AS Average_Rating
FROM feedback;


---------------------------------------------------------------
-- Query 17 : Rating Distribution
---------------------------------------------------------------

SELECT
    rating,
    COUNT(*) AS Total_Feedback
FROM feedback
GROUP BY rating
ORDER BY rating DESC;


---------------------------------------------------------------
-- Query 18 : Marketing Spend
---------------------------------------------------------------

SELECT
    ROUND(SUM(spend),2) AS Total_Spend
FROM marketing;


---------------------------------------------------------------
-- Query 19 : Revenue Generated from Marketing
---------------------------------------------------------------

SELECT
    ROUND(SUM(revenue_generated),2) AS Revenue_Generated
FROM marketing;


---------------------------------------------------------------
-- Query 20 : Average ROAS
---------------------------------------------------------------

SELECT
    ROUND(AVG(roas),2) AS Average_ROAS
FROM marketing;