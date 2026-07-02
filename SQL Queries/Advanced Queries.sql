-- ============================================================
-- ADVANCED SQL QUERIES
-- ============================================================

---------------------------------------------------------------
-- Query 67 : Rank Products by Revenue
---------------------------------------------------------------

SELECT
    p.product_name,
    SUM(oi.sales) AS Revenue,
    RANK() OVER(
        ORDER BY SUM(oi.sales) DESC
    ) AS Product_Rank
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name;


---------------------------------------------------------------
-- Query 68 : Dense Rank Products by Quantity Sold
---------------------------------------------------------------

SELECT
    p.product_name,
    SUM(oi.quantity) AS Quantity_Sold,
    DENSE_RANK() OVER(
        ORDER BY SUM(oi.quantity) DESC
    ) AS Dense_Rank
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name;


---------------------------------------------------------------
-- Query 69 : Row Number for Customers by Revenue
---------------------------------------------------------------

SELECT
    c.customer_name,
    SUM(o.order_total) AS Revenue,
    ROW_NUMBER() OVER(
        ORDER BY SUM(o.order_total) DESC
    ) AS Row_Num
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;


---------------------------------------------------------------
-- Query 70 : Top Customer in Each Segment
---------------------------------------------------------------

WITH Customer_Revenue AS
(
SELECT
    c.customer_segment,
    c.customer_name,
    SUM(o.order_total) AS Revenue,
    ROW_NUMBER() OVER(
        PARTITION BY c.customer_segment
        ORDER BY SUM(o.order_total) DESC
    ) AS rn
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_segment, c.customer_name
)

SELECT *
FROM Customer_Revenue
WHERE rn = 1;


---------------------------------------------------------------
-- Query 71 : Monthly Revenue with Previous Month Revenue
---------------------------------------------------------------

WITH Monthly_Revenue AS
(
SELECT
    order_year,
    order_month,
    SUM(order_total) AS Revenue
FROM orders
GROUP BY order_year, order_month
)

SELECT
    order_year,
    order_month,
    Revenue,
    LAG(Revenue)
    OVER(
        ORDER BY order_year, order_month
    ) AS Previous_Month_Revenue
FROM Monthly_Revenue;


---------------------------------------------------------------
-- Query 72 : Monthly Revenue with Next Month Revenue
---------------------------------------------------------------

WITH Monthly_Revenue AS
(
SELECT
    order_year,
    order_month,
    SUM(order_total) AS Revenue
FROM orders
GROUP BY order_year, order_month
)

SELECT
    order_year,
    order_month,
    Revenue,
    LEAD(Revenue)
    OVER(
        ORDER BY order_year, order_month
    ) AS Next_Month_Revenue
FROM Monthly_Revenue;


---------------------------------------------------------------
-- Query 73 : Running Revenue Total
---------------------------------------------------------------

WITH Monthly_Revenue AS
(
SELECT
    order_year,
    order_month,
    SUM(order_total) AS Revenue
FROM orders
GROUP BY order_year, order_month
)

SELECT
    order_year,
    order_month,
    Revenue,
    SUM(Revenue)
    OVER(
        ORDER BY order_year, order_month
    ) AS Running_Total
FROM Monthly_Revenue;


---------------------------------------------------------------
-- Query 74 : Average Revenue Across Months
---------------------------------------------------------------

WITH Monthly_Revenue AS
(
SELECT
    order_year,
    order_month,
    SUM(order_total) AS Revenue
FROM orders
GROUP BY order_year, order_month
)

SELECT
    order_year,
    order_month,
    Revenue,
    ROUND(
        AVG(Revenue) OVER(),2
    ) AS Average_Revenue
FROM Monthly_Revenue;


---------------------------------------------------------------
-- Query 75 : Top 5 Products in Each Category
---------------------------------------------------------------

WITH Product_Revenue AS
(
SELECT
    p.category,
    p.product_name,
    SUM(oi.sales) AS Revenue,
    ROW_NUMBER() OVER(
        PARTITION BY p.category
        ORDER BY SUM(oi.sales) DESC
    ) AS rn
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.category, p.product_name
)

SELECT *
FROM Product_Revenue
WHERE rn <= 5;


---------------------------------------------------------------
-- Query 76 : Marketing Campaign Ranking by ROAS
---------------------------------------------------------------

SELECT
    campaign_name,
    AVG(roas) AS ROAS,
    RANK() OVER(
        ORDER BY AVG(roas) DESC
    ) AS Campaign_Rank
FROM marketing
GROUP BY campaign_name;


---------------------------------------------------------------
-- Query 77 : Average Rating by Customer Segment (Window Function)
---------------------------------------------------------------

SELECT
    c.customer_name,
    c.customer_segment,
    f.rating,
    ROUND(
        AVG(f.rating)
        OVER(PARTITION BY c.customer_segment),2
    ) AS Segment_Avg_Rating
FROM customers c
JOIN feedback f
ON c.customer_id = f.customer_id;


---------------------------------------------------------------
-- Query 78 : Product Contribution to Total Revenue
---------------------------------------------------------------

SELECT
    p.product_name,
    SUM(oi.sales) AS Revenue,
    ROUND(
        SUM(oi.sales) * 100 /
        (SELECT SUM(sales) FROM order_items),2
    ) AS Revenue_Percentage
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Revenue DESC;


---------------------------------------------------------------
-- Query 79 : Executive KPI Dashboard Query
---------------------------------------------------------------

SELECT

COUNT(DISTINCT o.order_id) AS Total_Orders,

COUNT(DISTINCT c.customer_id) AS Total_Customers,

ROUND(SUM(o.order_total),2) AS Total_Revenue,

ROUND(AVG(o.order_total),2) AS Average_Order_Value,

ROUND(AVG(f.rating),2) AS Average_Rating,

ROUND(AVG(d.delivery_time_minutes),2) AS Average_Delivery_Time

FROM orders o

LEFT JOIN customers c
ON o.customer_id = c.customer_id

LEFT JOIN feedback f
ON o.order_id = f.order_id

LEFT JOIN delivery d
ON o.order_id = d.order_id;


---------------------------------------------------------------
-- Query 80 : Best Selling Product
---------------------------------------------------------------

SELECT
    p.product_name,
    SUM(oi.quantity) AS Quantity_Sold
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Quantity_Sold DESC
LIMIT 1;