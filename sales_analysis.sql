-- SQL Analysis: Sales Data
-- Dataset: sales_data.csv
-- Goal: Answer common business questions using SQL.

-- 1. View all sales records
SELECT *
FROM sales_data;

-- 2. Total revenue
SELECT SUM(Total_Sales) AS Total_Revenue
FROM sales_data;

-- 3. Total number of orders
SELECT COUNT(*) AS Total_Orders
FROM sales_data;

-- 4. Average order value
SELECT AVG(Total_Sales) AS Average_Order_Value
FROM sales_data;

-- 5. Total sales by region
SELECT
    Region,
    SUM(Total_Sales) AS Total_Sales
FROM sales_data
GROUP BY Region
ORDER BY Total_Sales DESC;

-- 6. Total quantity sold by product
SELECT
    Product,
    SUM(Quantity) AS Units_Sold
FROM sales_data
GROUP BY Product
ORDER BY Units_Sold DESC;

-- 7. Total sales by category
SELECT
    Category,
    SUM(Total_Sales) AS Total_Sales
FROM sales_data
GROUP BY Category
ORDER BY Total_Sales DESC;

-- 8. Top 5 orders by sales
SELECT
    Order_ID,
    Customer_Name,
    Product,
    Total_Sales
FROM sales_data
ORDER BY Total_Sales DESC
LIMIT 5;

-- 9. Monthly sales
SELECT
    EXTRACT(MONTH FROM CAST(Date AS DATE)) AS Sales_Month,
    SUM(Total_Sales) AS Monthly_Sales
FROM sales_data
GROUP BY EXTRACT(MONTH FROM CAST(Date AS DATE))
ORDER BY Sales_Month;

-- 10. Sales by customer
SELECT
    Customer_Name,
    SUM(Total_Sales) AS Customer_Sales
FROM sales_data
GROUP BY Customer_Name
ORDER BY Customer_Sales DESC;

-- 11. Orders above $1,000
SELECT
    Order_ID,
    Customer_Name,
    Product,
    Total_Sales
FROM sales_data
WHERE Total_Sales > 1000
ORDER BY Total_Sales DESC;

-- 12. Region and category performance
SELECT
    Region,
    Category,
    SUM(Total_Sales) AS Total_Sales
FROM sales_data
GROUP BY Region, Category
ORDER BY Region, Total_Sales DESC;

-- 13. Rank products by total sales
WITH product_sales AS (
    SELECT
        Product,
        SUM(Total_Sales) AS Total_Sales
    FROM sales_data
    GROUP BY Product
)
SELECT
    Product,
    Total_Sales,
    RANK() OVER (ORDER BY Total_Sales DESC) AS Sales_Rank
FROM product_sales
ORDER BY Sales_Rank;

-- 14. Running total of sales by date
SELECT
    Date,
    Order_ID,
    Total_Sales,
    SUM(Total_Sales) OVER (
        ORDER BY Date, Order_ID
    ) AS Running_Total_Sales
FROM sales_data
ORDER BY Date, Order_ID;
