import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("../data/processed/retail_sales_cleaned.csv", parse_dates=["Order_Date"])

print("Rows:", len(df))
print("Unique customers:", df["Customer_ID"].nunique())
print("Net Sales:", round(df["Net_Sales"].sum(), 2))
print("Profit:", round(df["Profit"].sum(), 2))
print("Profit Margin %:", round(df["Profit"].sum() / df["Net_Sales"].sum() * 100, 2))

region = df.groupby("Region", as_index=False)[["Net_Sales","Profit"]].sum()
category = df.groupby("Category", as_index=False)[["Net_Sales","Profit"]].sum()
monthly = df.assign(Month=df["Order_Date"].dt.to_period("M").astype(str)).groupby("Month", as_index=False)[["Net_Sales","Profit"]].sum()

print("\nRegion Performance")
print(region.sort_values("Profit", ascending=False))

print("\nCategory Performance")
print(category.sort_values("Profit", ascending=False))

loss_orders = df[df["Profit"] < 0]
print("\nLoss-making orders:", len(loss_orders))

region.sort_values("Profit").plot(kind="barh", x="Region", y="Profit", legend=False, title="Profit by Region")
plt.tight_layout()
plt.show()

category.sort_values("Profit").plot(kind="barh", x="Category", y="Profit", legend=False, title="Profit by Category")
plt.tight_layout()
plt.show()

monthly.plot(kind="line", x="Month", y="Net_Sales", legend=False, title="Monthly Net Sales Trend")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()
