SELECT * FROM DimAccount;
SELECT * FROM DimBranch;
SELECT * FROM DimCustomer;
SELECT * FROM FactTransaction;

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

EXEC DailyTransaction '2024-01-15', '2024-01-20'

DROP PROCEDURE DailyTransaction;

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

EXEC BalancePerCustomer @name = 'Shelly'	










SELECT name, state_desc FROM sys.databases WHERE name = 'DW';

USE DW;
GO
SELECT * FROM dbo.FactTransaction;