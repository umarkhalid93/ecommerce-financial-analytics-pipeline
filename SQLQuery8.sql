CREATE TABLE dbo.olist_orders(
order_id VARCHAR(50) PRIMARY KEY,
customer_id VARCHAR(50),
order_status VARCHAR (15),
order_purchase_timestamp DATETIME2,
order_approved_at DATETIME2,
order_delivered_carrier_date DATETIME2,
order_delivered_customer_date DATETIME2,
order_estimated_delivery_date DATETIME2
);
SELECT * FROM dbo.olist_orders;
SELECT TOP 10 * 
FROM dbo.olist_orders;

SELECT COUNT(*) AS TOTAL_ROW FROM dbo.olist_orders;
