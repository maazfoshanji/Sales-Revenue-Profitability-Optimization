-- Retail Business Performance & Profitability Analysis
-- Table expected: retail_sales
-- Columns: Order_ID, Order_Date, Customer_ID, Customer_Name, Region, State,
-- Category, Sub_Category, Product, Quantity, Sales, Discount, Cost, Profit,
-- Net_Sales, Profit_Margin

-- 1. Overall KPIs
SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT Customer_ID) AS unique_customers,
    ROUND(SUM(Sales), 2) AS gross_sales,
    ROUND(SUM(Net_Sales), 2) AS net_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Net_Sales), 0) * 100, 2) AS profit_margin_pct
FROM retail_sales;

-- 2. Region performance
SELECT
    Region,
    ROUND(SUM(Net_Sales), 2) AS net_sales,
    ROUND(SUM(Profit), 2) AS profit,
    COUNT(*) AS orders
FROM retail_sales
GROUP BY Region
ORDER BY profit DESC;

-- 3. Category performance
SELECT
    Category,
    ROUND(SUM(Net_Sales), 2) AS net_sales,
    ROUND(SUM(Profit), 2) AS profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Net_Sales), 0) * 100, 2) AS margin_pct
FROM retail_sales
GROUP BY Category
ORDER BY profit DESC;

-- 4. Sub-category profitability
SELECT
    Sub_Category,
    ROUND(SUM(Net_Sales), 2) AS net_sales,
    ROUND(SUM(Profit), 2) AS profit
FROM retail_sales
GROUP BY Sub_Category
ORDER BY profit ASC;

-- 5. Top 10 products by profit
SELECT
    Product,
    ROUND(SUM(Net_Sales), 2) AS net_sales,
    ROUND(SUM(Profit), 2) AS profit,
    SUM(Quantity) AS units_sold
FROM retail_sales
GROUP BY Product
ORDER BY profit DESC
LIMIT 10;

-- 6. Monthly sales trend
SELECT
    SUBSTR(Order_Date, 1, 7) AS month,
    ROUND(SUM(Net_Sales), 2) AS net_sales,
    ROUND(SUM(Profit), 2) AS profit
FROM retail_sales
GROUP BY SUBSTR(Order_Date, 1, 7)
ORDER BY month;

-- 7. Yearly performance
SELECT
    SUBSTR(Order_Date, 1, 4) AS year,
    ROUND(SUM(Net_Sales), 2) AS net_sales,
    ROUND(SUM(Profit), 2) AS profit
FROM retail_sales
GROUP BY SUBSTR(Order_Date, 1, 4)
ORDER BY year;

-- 8. Discount impact on profitability
SELECT
    ROUND(Discount * 100, 0) AS discount_pct,
    COUNT(*) AS orders,
    ROUND(SUM(Net_Sales), 2) AS net_sales,
    ROUND(SUM(Profit), 2) AS profit,
    ROUND(AVG(Profit_Margin) * 100, 2) AS avg_margin_pct
FROM retail_sales
GROUP BY Discount
ORDER BY Discount;

-- 9. Loss-making orders
SELECT
    Order_ID, Order_Date, Customer_ID, Product, Region,
    Net_Sales, Cost, Profit, Discount
FROM retail_sales
WHERE Profit < 0
ORDER BY Profit ASC;

-- 10. Top customers by net sales
SELECT
    Customer_ID,
    MAX(Customer_Name) AS customer_name,
    COUNT(*) AS orders,
    ROUND(SUM(Net_Sales), 2) AS net_sales,
    ROUND(SUM(Profit), 2) AS profit
FROM retail_sales
GROUP BY Customer_ID
ORDER BY net_sales DESC
LIMIT 10;
