/*
===============================================================================
Project: E-Commerce Average Order Value (AOV) Analysis
Database: Olist_Enterprise
Author: [Your Name]
Date: October 2026

Business Objective:
Calculate and compare the Average Order Value (AOV) between successfully 
delivered orders and canceled orders to identify potential revenue leakage 
in premium product categories.

Technical Approach:
- Utilized Common Table Expressions (CTEs) to pre-aggregate item-level data.
- Executed multi-table INNER JOINs connecting Orders and Order_Items.
- Applied CAST functions for precise financial formatting.

Key Finding:
Canceled orders possess an AOV of R$206.58, which is 50.7% higher than the 
AOV of delivered orders (R$137.04). This indicates a higher rate of buyer's 
remorse or logistical friction with premium purchases.
===============================================================================
*/

-- 1. Calculate Average Order Value for Delivered Orders
WITH Delivered_Totals AS (
    SELECT o.order_id, SUM(oi.price) AS Order_Total 
    FROM Order_Items oi
    JOIN Orders o ON o.order_id = oi.order_id 
    WHERE o.order_status = 'delivered'
    GROUP BY o.order_id
)
SELECT CAST(AVG(Order_Total) AS decimal(18,2)) AS AOV_Delivered 
FROM Delivered_Totals;

-- 2. Calculate Average Order Value for Canceled Orders
WITH Canceled_Totals AS (
    SELECT o.order_id, SUM(oi.price) AS Order_Total 
    FROM Order_Items oi
    JOIN Orders o ON o.order_id = oi.order_id 
    WHERE o.order_status = 'canceled'
    GROUP BY o.order_id
)
SELECT CAST(AVG(Order_Total) AS decimal(18,2)) AS AOV_Canceled 
FROM Canceled_Totals;


#################

SELECT customer_state, COUNT(customer_id) AS Total_Customer FROM Customers GROUP BY customer_state ORDER BY Total_Customer DESC;

Select order_status,Sum(price) AS Total_Revenue From Orders JOIN Order_Items ON Orders.order_id = Order_Items.order_id GROUP BY order_status ORDER BY Total_Revenue DESC;


Select product_category_name , Sum(price) AS Total_Revenue from Order_Items
JOIN Orders ON Orders.order_id=Order_Items.order_id 

JOIN Products ON Products.product_id = Order_Items.product_id  
WHERE Orders.order_status= 'delivered' 

GROUP BY product_category_name ORDER BY Total_Revenue Desc; 

WITH Order_Total AS(
SELECT Orders.order_id, SUM(price) As Order_Total from Order_Items 
JOIN Orders ON OrderS.order_id=Order_Items.order_id  

WHERE Orders.order_status='delivered' GROUP BY Orders.order_id
)
Select CAST(AVG(Order_Total) AS decimal(18,2)) As Average_Order_Value from Order_Total;


WITH Cancel_Total AS(
Select Orders.order_id, SUM(price) As Order_Total from Order_Items 
JOIN Orders ON OrderS.order_id=Order_Items.order_id  

WHERE Orders.order_status='canceled' GROUP BY Orders.order_id
)
Select CAST(AVG(Order_Total) AS decimal(18,2)) As Average_Order_cancelled from Cancel_Total;

SELECT DISTINCT order_status FROM Orders;






