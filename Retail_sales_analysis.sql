CREATE DATABASE IF NOT EXISTS sales_profitability;

USE sales_profitability;
SELECT COUNT(*) AS total_records
FROM sales_profitability.retail_sales;
SELECT *
FROM sales_profitability.retail_sales
LIMIT 10;
SELECT
    COUNT(*) AS total_records,
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS missing_sales,
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS missing_profit,
    SUM(CASE WHEN Order_Date IS NULL OR TRIM(Order_Date) = '' THEN 1 ELSE 0 END) AS missing_dates
FROM sales_profitability.retail_sales;
SELECT
    ROUND(SUM(Net_Sales), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Net_Sales), 0) * 100, 2)
        AS profit_margin_percentage
FROM sales_profitability.retail_sales;
SELECT
    Category,
    COUNT(*) AS total_orders,
    ROUND(SUM(Net_Sales), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Net_Sales), 0) * 100, 2)
        AS profit_margin_percentage
FROM sales_profitability.retail_sales
GROUP BY Category
ORDER BY total_profit DESC;
SELECT
    Category,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN Profit < 0 THEN 1 ELSE 0 END)
        AS loss_making_transactions,
    ROUND(SUM(CASE WHEN Profit < 0 THEN Profit ELSE 0 END), 2)
        AS total_losses,
    ROUND(
        100.0 * SUM(CASE WHEN Profit < 0 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS loss_transaction_percentage
FROM sales_profitability.retail_sales
GROUP BY Category
ORDER BY loss_making_transactions DESC;
SELECT
    Category,
    ROUND(AVG(Discount) * 100, 2) AS avg_discount_pct,
    ROUND(AVG(CASE WHEN Profit < 0 THEN Discount END) * 100, 2)
        AS avg_discount_on_losses_pct,
    ROUND(AVG(CASE WHEN Profit >= 0 THEN Discount END) * 100, 2)
        AS avg_discount_on_profitable_sales_pct
FROM sales_profitability.retail_sales
GROUP BY Category;
SELECT
    ROUND(Discount * 100, 0) AS discount_percentage,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN Profit < 0 THEN 1 ELSE 0 END)
        AS loss_making_transactions,
    ROUND(AVG(Profit), 2) AS average_profit,
    ROUND(
        100.0 * SUM(CASE WHEN Profit < 0 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS loss_rate_percentage
FROM sales_profitability.retail_sales
GROUP BY ROUND(Discount * 100, 0)
ORDER BY discount_percentage;
SELECT
    Product,
    Category,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN Profit < 0 THEN 1 ELSE 0 END)
        AS loss_making_transactions,
    ROUND(SUM(CASE WHEN Profit < 0 THEN Profit ELSE 0 END), 2)
        AS total_losses,
    ROUND(AVG(Discount) * 100, 2)
        AS average_discount_pct
FROM sales_profitability.retail_sales
GROUP BY Product, Category
HAVING SUM(CASE WHEN Profit < 0 THEN 1 ELSE 0 END) > 0
ORDER BY total_losses ASC
LIMIT 10;
SELECT
    Region,
    COUNT(*) AS total_transactions,
    ROUND(SUM(Net_Sales), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Net_Sales), 0) * 100, 2
    ) AS profit_margin_percentage,
    SUM(CASE WHEN Profit < 0 THEN 1 ELSE 0 END)
        AS loss_making_transactions
FROM sales_profitability.retail_sales
GROUP BY Region
ORDER BY total_profit DESC;
SELECT
    Order_ID,
    COUNT(*) AS occurrences
FROM sales_profitability.retail_sales
GROUP BY Order_ID
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;
SELECT
    COUNT(*) AS total_records,
    MIN(STR_TO_DATE(Order_Date, '%Y-%m-%d')) AS earliest_date,
    MAX(STR_TO_DATE(Order_Date, '%Y-%m-%d')) AS latest_date,
    SUM(
        CASE
            WHEN STR_TO_DATE(Order_Date, '%Y-%m-%d') IS NULL
            THEN 1 ELSE 0
        END
    ) AS invalid_dates
FROM sales_profitability.retail_sales;
SELECT
    COUNT(*) AS total_records,
    SUM(
        CASE
            WHEN ABS(Net_Sales - Sales * (1 - Discount)) > 0.05
            THEN 1 ELSE 0
        END
    ) AS incorrect_net_sales,
    SUM(
        CASE
            WHEN Net_Sales <> 0
             AND ABS(Profit_Margin - Profit / Net_Sales) > 0.001
            THEN 1 ELSE 0
        END
    ) AS incorrect_profit_margins
FROM sales_profitability.retail_sales;
SELECT
    Order_ID,
    COUNT(*) AS occurrences
FROM sales_profitability.retail_sales
GROUP BY Order_ID
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;
SELECT
    YEAR(STR_TO_DATE(Order_Date, '%Y-%m-%d')) AS sales_year,
    COUNT(*) AS total_transactions,
    ROUND(SUM(Net_Sales), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Net_Sales), 0) * 100, 2)
        AS profit_margin_percentage
FROM sales_profitability.retail_sales
GROUP BY sales_year
ORDER BY sales_year;
SELECT
    YEAR(STR_TO_DATE(Order_Date, '%Y-%m-%d')) AS sales_year,
    MONTH(STR_TO_DATE(Order_Date, '%Y-%m-%d')) AS sales_month,
    COUNT(*) AS total_transactions,
    ROUND(SUM(Net_Sales), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Net_Sales), 0) * 100, 2
    ) AS profit_margin_percentage
FROM sales_profitability.retail_sales
GROUP BY sales_year, sales_month
ORDER BY sales_year, sales_month;
SELECT
    Product,
    Category,
    COUNT(*) AS total_transactions,
    ROUND(SUM(Net_Sales), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Net_Sales), 0) * 100, 2
    ) AS profit_margin_percentage
FROM sales_profitability.retail_sales
GROUP BY Product, Category
ORDER BY total_profit DESC
LIMIT 10;
SELECT
    Product,
    Category,
    COUNT(*) AS total_transactions,
    ROUND(SUM(Net_Sales), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Net_Sales), 0) * 100, 2
    ) AS profit_margin_percentage
FROM sales_profitability.retail_sales
GROUP BY Product, Category
ORDER BY total_profit ASC
LIMIT 10;
