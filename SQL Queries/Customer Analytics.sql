-- ============================================================
-- CUSTOMER ANALYTICS
-- ============================================================

---------------------------------------------------------------
-- Query 21 : Customers by Segment
---------------------------------------------------------------

SELECT
    customer_segment,
    COUNT(*) AS Total_Customers
FROM customers
GROUP BY customer_segment
ORDER BY Total_Customers DESC;


---------------------------------------------------------------
-- Query 22 : Revenue by Customer Segment
---------------------------------------------------------------

SELECT
    c.customer_segment,
    ROUND(SUM(o.order_total),2) AS Revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_segment
ORDER BY Revenue DESC;


---------------------------------------------------------------
-- Query 23 : Average Order Value by Customer Segment
---------------------------------------------------------------

SELECT
    c.customer_segment,
    ROUND(AVG(o.order_total),2) AS Avg_Order_Value
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_segment;


---------------------------------------------------------------
-- Query 24 : Top 10 Customers by Revenue
---------------------------------------------------------------

SELECT
    c.customer_name,
    ROUND(SUM(o.order_total),2) AS Revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY Revenue DESC
LIMIT 10;


---------------------------------------------------------------
-- Query 25 : Top 10 Customers by Orders
---------------------------------------------------------------

SELECT
    c.customer_name,
    COUNT(o.order_id) AS Total_Orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY Total_Orders DESC
LIMIT 10;


---------------------------------------------------------------
-- Query 26 : Customer Lifetime Value
---------------------------------------------------------------

SELECT
    c.customer_name,
    ROUND(SUM(o.order_total),2) AS Customer_Lifetime_Value
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY Customer_Lifetime_Value DESC;


---------------------------------------------------------------
-- Query 27 : Average Rating by Customer Segment
---------------------------------------------------------------

SELECT
    c.customer_segment,
    ROUND(AVG(f.rating),2) AS Average_Rating
FROM customers c
JOIN feedback f
ON c.customer_id = f.customer_id
GROUP BY c.customer_segment;


---------------------------------------------------------------
-- Query 28 : Registration Trend
---------------------------------------------------------------

SELECT
    registration_year,
    registration_month,
    COUNT(*) AS New_Customers
FROM customers
GROUP BY registration_year, registration_month
ORDER BY registration_year, registration_month;


---------------------------------------------------------------
-- Query 29 : Customers with Highest Average Order Value
---------------------------------------------------------------

SELECT
    customer_name,
    avg_order_value
FROM customers
ORDER BY avg_order_value DESC
LIMIT 10;


---------------------------------------------------------------
-- Query 30 : Repeat Customers
---------------------------------------------------------------

SELECT
    customer_id,
    COUNT(order_id) AS Orders_Placed
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1
ORDER BY Orders_Placed DESC;


-- ============================================================
-- SALES ANALYTICS
-- ============================================================

---------------------------------------------------------------
-- Query 31 : Revenue by Category
---------------------------------------------------------------

SELECT
    p.category,
    ROUND(SUM(oi.sales),2) AS Revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY Revenue DESC;


---------------------------------------------------------------
-- Query 32 : Revenue by Brand
---------------------------------------------------------------

SELECT
    p.brand,
    ROUND(SUM(oi.sales),2) AS Revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.brand
ORDER BY Revenue DESC;


---------------------------------------------------------------
-- Query 33 : Top 10 Products by Revenue
---------------------------------------------------------------

SELECT
    p.product_name,
    ROUND(SUM(oi.sales),2) AS Revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Revenue DESC
LIMIT 10;


---------------------------------------------------------------
-- Query 34 : Top 10 Products by Quantity Sold
---------------------------------------------------------------

SELECT
    p.product_name,
    SUM(oi.quantity) AS Quantity_Sold
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Quantity_Sold DESC
LIMIT 10;


---------------------------------------------------------------
-- Query 35 : Monthly Revenue
---------------------------------------------------------------

SELECT
    order_year,
    order_month,
    ROUND(SUM(order_total),2) AS Revenue
FROM orders
GROUP BY order_year, order_month
ORDER BY order_year, order_month;


---------------------------------------------------------------
-- Query 36 : Revenue by Weekday
---------------------------------------------------------------

SELECT
    weekday,
    ROUND(SUM(order_total),2) AS Revenue
FROM orders
GROUP BY weekday
ORDER BY Revenue DESC;


---------------------------------------------------------------
-- Query 37 : Sales by Payment Method
---------------------------------------------------------------

SELECT
    payment_method,
    ROUND(SUM(order_total),2) AS Revenue
FROM orders
GROUP BY payment_method
ORDER BY Revenue DESC;


---------------------------------------------------------------
-- Query 38 : Average Basket Size
---------------------------------------------------------------

SELECT
    ROUND(AVG(total_items),2) AS Average_Basket_Size
FROM
(
    SELECT
        order_id,
        SUM(quantity) AS total_items
    FROM order_items
    GROUP BY order_id
) basket;


---------------------------------------------------------------
-- Query 39 : Category-wise Quantity Sold
---------------------------------------------------------------

SELECT
    p.category,
    SUM(oi.quantity) AS Quantity_Sold
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY Quantity_Sold DESC;


---------------------------------------------------------------
-- Query 40 : Brand-wise Quantity Sold
---------------------------------------------------------------

SELECT
    p.brand,
    SUM(oi.quantity) AS Quantity_Sold
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.brand
ORDER BY Quantity_Sold DESC;