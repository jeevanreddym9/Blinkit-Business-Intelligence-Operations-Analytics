-- ============================================================
-- INVENTORY ANALYTICS
-- ============================================================

---------------------------------------------------------------
-- Query 41 : Total Stock Received
---------------------------------------------------------------

SELECT
    SUM(stock_received) AS Total_Stock_Received
FROM inventory;


---------------------------------------------------------------
-- Query 42 : Total Damaged Stock
---------------------------------------------------------------

SELECT
    SUM(damaged_stock) AS Total_Damaged_Stock
FROM inventory;


---------------------------------------------------------------
-- Query 43 : Damage Percentage
---------------------------------------------------------------

SELECT
    ROUND(
        (SUM(damaged_stock) * 100.0) /
        SUM(stock_received),2
    ) AS Damage_Percentage
FROM inventory;


---------------------------------------------------------------
-- Query 44 : Stock Received by Month
---------------------------------------------------------------

SELECT
    year,
    month,
    SUM(stock_received) AS Stock_Received
FROM inventory
GROUP BY year, month
ORDER BY year, month;


---------------------------------------------------------------
-- Query 45 : Damaged Stock by Month
---------------------------------------------------------------

SELECT
    year,
    month,
    SUM(damaged_stock) AS Damaged_Stock
FROM inventory
GROUP BY year, month
ORDER BY year, month;


---------------------------------------------------------------
-- Query 46 : Damage by Category
---------------------------------------------------------------

SELECT
    p.category,
    SUM(i.damaged_stock) AS Damaged_Stock
FROM inventory i
JOIN products p
ON i.product_id = p.product_id
GROUP BY p.category
ORDER BY Damaged_Stock DESC;


---------------------------------------------------------------
-- Query 47 : Top 10 Products with Highest Damage
---------------------------------------------------------------

SELECT
    p.product_name,
    SUM(i.damaged_stock) AS Damage
FROM inventory i
JOIN products p
ON i.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Damage DESC
LIMIT 10;


---------------------------------------------------------------
-- Query 48 : Total Stock Received by Category
---------------------------------------------------------------

SELECT
    p.category,
    SUM(i.stock_received) AS Stock
FROM inventory i
JOIN products p
ON i.product_id = p.product_id
GROUP BY p.category
ORDER BY Stock DESC;



-- ============================================================
-- DELIVERY ANALYTICS
-- ============================================================

---------------------------------------------------------------
-- Query 49 : Average Delivery Time
---------------------------------------------------------------

SELECT
    ROUND(AVG(delivery_time_minutes),2) AS Avg_Delivery_Time
FROM delivery;


---------------------------------------------------------------
-- Query 50 : Average Distance Covered
---------------------------------------------------------------

SELECT
    ROUND(AVG(distance_km),2) AS Avg_Distance
FROM delivery;


---------------------------------------------------------------
-- Query 51 : Delivery Status Distribution
---------------------------------------------------------------

SELECT
    delivery_status,
    COUNT(*) AS Orders
FROM delivery
GROUP BY delivery_status;


---------------------------------------------------------------
-- Query 52 : Delay Reasons
---------------------------------------------------------------

SELECT
    reasons_if_delayed,
    COUNT(*) AS Total_Delays
FROM delivery
GROUP BY reasons_if_delayed
ORDER BY Total_Delays DESC;


---------------------------------------------------------------
-- Query 53 : Average Delivery Time by Partner
---------------------------------------------------------------

SELECT
    delivery_partner_id,
    ROUND(AVG(delivery_time_minutes),2) AS Avg_Time
FROM delivery
GROUP BY delivery_partner_id
ORDER BY Avg_Time;


---------------------------------------------------------------
-- Query 54 : Average Distance by Partner
---------------------------------------------------------------

SELECT
    delivery_partner_id,
    ROUND(AVG(distance_km),2) AS Avg_Distance
FROM delivery
GROUP BY delivery_partner_id
ORDER BY Avg_Distance DESC;


---------------------------------------------------------------
-- Query 55 : Longest Deliveries
---------------------------------------------------------------

SELECT
    order_id,
    delivery_time_minutes
FROM delivery
ORDER BY delivery_time_minutes DESC
LIMIT 10;



-- ============================================================
-- CUSTOMER FEEDBACK ANALYTICS
-- ============================================================

---------------------------------------------------------------
-- Query 56 : Feedback Count by Sentiment
---------------------------------------------------------------

SELECT
    sentiment,
    COUNT(*) AS Total
FROM feedback
GROUP BY sentiment;


---------------------------------------------------------------
-- Query 57 : Feedback Count by Category
---------------------------------------------------------------

SELECT
    feedback_category,
    COUNT(*) AS Total
FROM feedback
GROUP BY feedback_category
ORDER BY Total DESC;


---------------------------------------------------------------
-- Query 58 : Average Rating by Sentiment
---------------------------------------------------------------

SELECT
    sentiment,
    ROUND(AVG(rating),2) AS Avg_Rating
FROM feedback
GROUP BY sentiment;


---------------------------------------------------------------
-- Query 59 : Monthly Feedback Trend
---------------------------------------------------------------

SELECT
    feedback_year,
    feedback_month,
    COUNT(*) AS Feedback_Count
FROM feedback
GROUP BY feedback_year, feedback_month
ORDER BY feedback_year, feedback_month;


---------------------------------------------------------------
-- Query 60 : Average Rating by Delivery Status
---------------------------------------------------------------

SELECT
    d.delivery_status,
    ROUND(AVG(f.rating),2) AS Avg_Rating
FROM delivery d
JOIN feedback f
ON d.order_id = f.order_id
GROUP BY d.delivery_status;



-- ============================================================
-- MARKETING ANALYTICS
-- ============================================================

---------------------------------------------------------------
-- Query 61 : Spend by Channel
---------------------------------------------------------------

SELECT
    channel,
    ROUND(SUM(spend),2) AS Total_Spend
FROM marketing
GROUP BY channel
ORDER BY Total_Spend DESC;


---------------------------------------------------------------
-- Query 62 : Revenue by Channel
---------------------------------------------------------------

SELECT
    channel,
    ROUND(SUM(revenue_generated),2) AS Revenue
FROM marketing
GROUP BY channel
ORDER BY Revenue DESC;


---------------------------------------------------------------
-- Query 63 : Average ROAS by Channel
---------------------------------------------------------------

SELECT
    channel,
    ROUND(AVG(roas),2) AS Avg_ROAS
FROM marketing
GROUP BY channel
ORDER BY Avg_ROAS DESC;


---------------------------------------------------------------
-- Query 64 : Campaign Performance
---------------------------------------------------------------

SELECT
    campaign_name,
    ROUND(SUM(revenue_generated),2) AS Revenue,
    ROUND(SUM(spend),2) AS Spend,
    ROUND(AVG(roas),2) AS ROAS
FROM marketing
GROUP BY campaign_name
ORDER BY Revenue DESC;


---------------------------------------------------------------
-- Query 65 : Highest Click Campaigns
---------------------------------------------------------------

SELECT
    campaign_name,
    SUM(clicks) AS Clicks
FROM marketing
GROUP BY campaign_name
ORDER BY Clicks DESC
LIMIT 10;


---------------------------------------------------------------
-- Query 66 : Highest Conversion Campaigns
---------------------------------------------------------------

SELECT
    campaign_name,
    SUM(conversions) AS Conversions
FROM marketing
GROUP BY campaign_name
ORDER BY Conversions DESC
LIMIT 10;