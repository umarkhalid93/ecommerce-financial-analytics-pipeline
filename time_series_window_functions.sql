Select product_category_name, CAST(SUM(price) AS decimal(18,2)) AS Revenue_Generated from Order_Items 
JOIN Products ON Order_Items.product_id=Products.product_id
GROUP BY product_category_name ORDER BY Revenue_Generated DESC;


WITH State_Revenu AS(
SELECT   product_category_name, customer_state, CAST(SUM(price) AS decimal(18,2)) AS Total_Revenue 

FROM Order_Items

JOIN Products ON Order_Items.product_id=Products.product_id
JOIN Orders ON Order_Items.order_id=Orders.order_id
jOIN Customers ON Orders.customer_id=Customers.customer_id

GROUP BY  customer_state, product_category_name  

),
Ranked_Revenue AS(
SELECT customer_state, 
product_category_name, 
Total_Revenue, ROW_NUMBER()  OVER (PARTITION BY customer_state ORDER BY Total_Revenue Desc) as row_num 
FROM State_Revenu
)

Select * from Ranked_Revenue WHERE row_num <= 5 
ORDER BY customer_state ASC, row_num ASC;

WITH Monthly_Revenue AS(
Select cast(sum(price) As decimal(18,2) ) As total_revenue , FORMAT(Orders.order_purchase_timestamp,('yyyy-MM')) As Order_Month from Order_Items JOIN  Orders On Orders.Order_id= Order_Items.Order_id
Group By FORMAT(Orders.order_purchase_timestamp,('yyyy-MM')) 
)

SELECT total_revenue, Order_Month, LAG(total_revenue) OVER(ORDER BY Order_Month ASC) AS previous_revenue, total_revenue-LAG(total_revenue) OVER(ORDER BY Order_Month ASC) as MOM_GROWTH from Monthly_Revenue;


WITH Monthly_Revenue AS(
Select cast(sum(price) As decimal(18,2) ) As total_revenue , CONVERT(VARCHAR(7), Orders.order_purchase_timestamp, 120) As Order_Month from Order_Items JOIN  Orders On Orders.Order_id= Order_Items.Order_id
Group By CONVERT(VARCHAR(7), Orders.order_purchase_timestamp, 120) 
)
SELECT Order_Month, total_revenue, SUM(total_revenue) OVER(ORDER BY Order_Month ASC) as Running_total,total_revenue-LAG(total_revenue) OVER(ORDER BY Order_Month ASC) as MOM_GROWTH  ,LEAD(total_revenue) OVER(ORDER BY Order_Month ASC) AS next_month from Monthly_Revenue;
