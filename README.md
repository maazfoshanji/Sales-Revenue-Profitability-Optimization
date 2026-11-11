# Sales-Revenue-Profitability-Optimization \& Profitability Analysis

End-to-end **Data Analyst portfolio project** using Excel, SQL, Python/Pandas and data visualization to analyze retail sales, profitability, regional performance, category performance and loss-making transactions.

## Project Overview

The project analyzes a realistic retail dataset covering **2023–2025**. The workflow includes raw-data cleaning, business KPI analysis, SQL queries, Python EDA, Excel reporting and dashboard creation.

## Dataset Summary

* **Raw records:** 7,535
* **Cleaned records:** 7,500
* **Exact duplicates removed:** 35
* **Unique customers:** 800
* **Regions:** North, South, East, West, Central
* **Categories:** Technology, Furniture, Office Supplies

## Tools Used

* **Excel** — data cleaning, KPI summary and dashboard
* **SQL** — business queries and profitability analysis
* **Python / Pandas** — exploratory data analysis
* **Matplotlib** — visualizations
* **GitHub** — project documentation and portfolio hosting

## Key KPIs

|KPI|Result|
|-|-:|
|Total Orders|7,500|
|Unique Customers|800|
|Net Sales|₹198,854,948.37|
|Total Profit|₹34,867,417.88|
|Profit Margin|17.53%|
|Loss-Making Orders|402|

## Key Business Insights

* **South** generated the highest total profit.
* **Technology** was the most profitable category.
* **402 orders** were loss-making, showing the importance of discount and cost control.
* Regional and category analysis helps identify where sales growth is translating into healthy profitability.
* Profit margin should be monitored alongside revenue to avoid unprofitable growth.

## Visualizations

### Profit by Region

!\[Profit by Region](profit\_by\_region.png)

### Profit by Category

!\[Profit by Category](profit\_by\_category.png)

### Monthly Net Sales Trend

!\[Monthly Net Sales Trend](monthly\_net\_sales\_trend.png)

## Repository Files

|File|Purpose|
|-|-|
|`retail\_sales\_raw.csv`|Original raw dataset|
|`retail\_sales\_cleaned.csv`|Cleaned dataset used for analysis|
|`Retail\_Business\_Analysis.xlsx`|Excel analysis, KPI summary and dashboard|
|`retail\_analysis.sql`|SQL business-analysis queries|
|`Retail_sales_analysis.sql`|Additional SQL queries for retail sales and profitability analysis|
|`retail\_analysis.py`|Python/Pandas analysis script|
|`business\_insights.md`|Detailed findings and recommendations|
|`profit\_by\_region.png`|Regional profitability visualization|
|`profit\_by\_category.png`|Category profitability visualization|
|`monthly\_net\_sales\_trend.png`|Monthly sales trend visualization|

## Data Cleaning Performed

* Removed exact duplicate records.
* Recovered missing customer names using Customer ID mapping where possible.
* Filled unsupported missing state values as `Unknown` instead of guessing.
* Added **Net Sales = Sales × (1 - Discount)**.
* Added **Profit Margin = Profit / Net Sales**.
* Standardized date and numeric fields for analysis.

## SQL Analysis

The SQL analysis covers overall KPIs, regional performance, category and sub-category profitability, top products, monthly/yearly trends, discount impact, loss-making orders and top customers.

## Resume-Ready Project Description

**Retail Business Performance \& Profitability Analysis** — Analyzed **7,500 retail order records** using Python, SQL and Excel. Cleaned and transformed raw sales data, evaluated revenue and profitability trends, identified **402 loss-making transactions**, and developed a structured Excel dashboard to communicate regional, category and KPI performance.

## Author

**Maaz Foshanji**  
Data Analyst | Python | SQL | Excel | Power BI | Tableau

