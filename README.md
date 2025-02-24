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

- ETL results are checked via Talend in SSMS using the SELECT query for each Dimensional Table and Fact Table.

![img_url]()

### Create 2 Stored Procedures
- Stored procedures (`DailyTransaction`) used to help calculate the number of transactions and their total nominal value each day.

<details>
  <summary>SQL Query</summary>

```SQL
  CREATE PROCEDURE DailyTransaction
(
	@start_date DATE,
	@end_date DATE
)
AS
BEGIN
	SELECT
		CAST(TransactionDate AS DATE) AS Date,
		COUNT(*) AS TotalTransactions,
		SUM(Amount) AS TotalAmount
	FROM 
		FactTransaction
	WHERE 
		TransactionDate BETWEEN @start_date AND @end_date
	GROUP BY 
		CAST(TransactionDate AS DATE)
	ORDER BY 
		Date;
END


```
</details>

- Execute procedure daily transaction from 15 to 20 January 2024
```SQL
EXEC DailyTransaction '2024-01-15', '2024-01-20'
```

Result:
![img_url]()

- Stored procedures (`BalancePerCustomer`) used to find out the remaining balance per-customer

<details>
  <summary>SQL Query</summary>

```SQL
  CREATE PROCEDURE BalancePerCustomer
	@name NVARCHAR(100)
	AS
	BEGIN
		SELECT 
			c.CustomerName,
			a.AccountType,
			a.Balance,
			a.Balance + SUM(CASE WHEN t.transactiontype = 'Deposit'
			THEN t.Amount ELSE -t.Amount END) AS CurrentBalance

		FROM 
			DimAccount a
		INNER JOIN DimCustomer c ON a.CustomerID = c.customerid
		LEFT JOIN FactTransaction t ON a.accountid = t.accountid

		WHERE 
		c.CustomerName LIKE '%' + @name + '%' AND
		a.status = 'active'

		GROUP BY 
		c.CustomerName, a.AccountType, a.Balance;

END

```
</details>

- Execute procedure daily transaction from 15 to 20 January 2024
```SQL
EXEC BalancePerCustomer @name = 'Shelly'
```

Result:
![img_url]()

## Results
- Successfully created the Data Warehouse and implemented the required ETL processes.
- Developed stored procedures to provide quick data summaries.
- Achieved efficient data extraction, transformation, and loading from multiple sources.

## Conclusion
This project demonstrated the ability to design and implement a Data Warehouse, develop ETL processes, and create stored procedures to optimize data analysis and reporting for a banking industry client.

## Project Deliverables
- 🎯 [Interactive Dashboard](https://lookerstudio.google.com/u/0/reporting/f855f594-3b75-4eca-9171-8f1d2438de93)
- 💻 [BigQuery SQL Syntax](https://github.com/renopasaribu17/Big-Data-Analytics-KimiaFarma/blob/11bd4e50e2749af26ec3b820ca93091391e14824/Syntax%20BigQuery.sql)

## Author: Reno Bonasahata Pasaribu
📫 [Email](renopasaribu17@gmail.com)
🌐 [LinkedIn](linkedin.com/in/renopasaribu)
