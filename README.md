# Designing Data Warehouse & Stored Procedures for id/x partner's Client 📊
ID/X Partners (PT IDX Consulting) was founded in 2002 and has been providing services to companies across Asia and Australia in various industries, especially financial services, telecommunications, manufacturing, and retail. ID/X Partners offers consulting services that specialize in utilizing Data Analytic and Decisioning (DAD) solutions, combined with risk management and integrated marketing disciplines, to help clients optimize portfolio profitability and business processes.

## Overview
This project was completed as part of the Data Engineer Test for ID/X Partners. The goal of the project was to create a Data Warehouse and implement ETL processes to optimize data extraction, transformation, and loading from multiple sources for a banking industry client.

### Tools & Technologies Used:
- 🦫 Open Talend Studio
- 📁 Microsoft SQL Server
- ⌨ Server Management Studio (SSMS)
- 📊 GitHub

## Problem Statement
The client faced challenges in extracting data from various sources (Excel, CSV, and SQL Server databases) simultaneously, leading to delays in reporting and data analysis. The primary objective was to streamline the ETL process and create a centralized Data Warehouse to facilitate efficient data analysis and reporting.

## Solution
### Data Warehouse Creation
- Restore sample.bak database is done as a data source to be used
- Create Data Warehouse database

![img_url]()

- Design and implement a new Data Warehouse named `DWH` with three dimension tables (`DimAccount`, `DimCustomer`, `DimBranch`) and one fact table (`FactTransaction`).

![img_url]()

### Create ETL Job for Dimension Table
- Each database connection is created to connect Microsoft SQL Server to Talend

![img_url]()

- Schema retrieval is performed for each table created in DWH database or sample.bak

![img_url]()

- Develop ETL jobs using Talend to migrate data from various sources into the dimension tables.
- Specifically, transform and load data into the `DimCustomer` table from the combination of the customer, city and state tables to retrieve the CityName and StateName columns.
- UPCASE is used so that the output becomes capitalized according to the provisions.

![img_url]()

### Create ETL Job for Fact Table

- Combine transaction data from Excel, CSV, and SQL Server into a single `FactTransaction` table, ensuring no duplicate rows.
- Change the column name to Pascal Case then and the date format to "yyyy-MM-dd HH:mm:ss" using tMap

![img_url]()

4. **Stored Procedures**: Create two stored procedures (`DailyTransaction` and `BalancePerCustomer`) to provide quick summaries of transaction data and customer balances.

## Results
- Successfully created the Data Warehouse and implemented the required ETL processes.
- Developed stored procedures to provide quick data summaries.
- Achieved efficient data extraction, transformation, and loading from multiple sources.

## Conclusion
This project demonstrated the ability to design and implement a Data Warehouse, develop ETL processes, and create stored procedures to optimize data analysis and reporting for a banking industry client.

<details>
  <summary>SQL Query</summary>

```SQL
  CREATE TABLE dataset_kimiafarma.kf_analisis AS
SELECT ft.transaction_id, ft.date, ft.branch_id, kc.branch_name, kc.kota, kc.provinsi, kc.rating as rating_cabang, ft.customer_name, ft.product_id, p.product_name, ft.price as actual_price, ft.discount_percentage, 

CASE
    WHEN ft.price <= 50000 THEN 0.1
    WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
    WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.2
    WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
    WHEN ft.price > 500000 THEN 0.3
        END AS persentase_gross_laba,

ft.price - (ft.price * ft.discount_percentage) as nett_sales,

CASE
    WHEN ft.price <= 50000 THEN 0.1 * ft.price
    WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15 * ft.price
    WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.2 * ft.price
    WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25 * ft.price
    WHEN ft.price > 500000 THEN 0.3 * ft.price
        END AS nett_profit,

ft.rating as rating_transaksi

FROM dataset_kimiafarma.kf_final_transaction as ft

LEFT JOIN dataset_kimiafarma.kf_kantor_cabang as kc
  ON ft.branch_id = kc.branch_id

LEFT JOIN dataset_kimiafarma.kf_product as p
  ON ft.product_id = p.product_id;

```
</details>

![img_url](https://github.com/renopasaribu17/Big-Data-Analytics-KimiaFarma/blob/main/assets/Data%20Analysis%20and%20Aggregation.png?raw=true)

## Dashboard Visualization & Insights

### Dashboard
![img_url](https://github.com/renopasaribu17/Big-Data-Analytics-KimiaFarma/blob/main/assets/Performance_Analytics_Dashboard.png?raw=true)

### Key Insights
- Total profit reached IDR98.6 billion, with an average branch rating of 4.4 and a total of 672.5 thousand transactions.
- West Java dominates the number of transactions and sales at the provincial level.
- There is a significant purchasing trend for hypnotic and anxiolytic drugs, indicating the high demand of the Indonesian people for stress and anxiety management solutions.
- Kimia Farma branches in Pematangsiantar, Jambi, and Batam have a high reputation for service quality (highest branch rating), but lower transaction ratings indicate potential for improvement in the transaction experience.

### Recommendations
- Discount Strategy Optimization: Focus on high margin product categories (>20%).
- Service Quality Improvement: Special training for low rating branches.
- Product Expansion: Adding product variants for high sales areas

## Project Deliverables
- 🎯 [Interactive Dashboard](https://lookerstudio.google.com/u/0/reporting/f855f594-3b75-4eca-9171-8f1d2438de93)
- 💻 [BigQuery SQL Syntax](https://github.com/renopasaribu17/Big-Data-Analytics-KimiaFarma/blob/11bd4e50e2749af26ec3b820ca93091391e14824/Syntax%20BigQuery.sql)

## Author: Reno Bonasahata Pasaribu
📫 [Email](renopasaribu17@gmail.com)
🌐 [LinkedIn](linkedin.com/in/renopasaribu)
