-- Membuat tabel DimCustomer
CREATE TABLE DimCustomer (
    CustomerID INT NOT NULL PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    Address VARCHAR(255),
    Age INT,
    Gender VARCHAR(10),
    Email VARCHAR(50),
    CityName VARCHAR(50),
    StateName VARCHAR(50)
);

-- Membuat tabel DimAccount
CREATE TABLE DimAccount (
    AccountID INT PRIMARY KEY NOT NULL,
    CustomerID INT NOT NULL,
    AccountType VARCHAR(10),
    Balance INT,
    DateOpened DATETIME,
    Status VARCHAR(10),
    FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID)
);

-- Membuat tabel DimBranch
CREATE TABLE DimBranch (
    BranchID INT NOT NULL PRIMARY KEY,
    BranchName VARCHAR(50) NOT NULL,
    BranchLocation VARCHAR(50)
);

-- Membuat tabel FactTransaction
CREATE TABLE FactTransaction (
    TransactionID INT PRIMARY KEY NOT NULL,
    AccountID INT NOT NULL,
    BranchID INT NOT NULL,
    TransactionDate DATE,
    Amount INT,
    TransactionType VARCHAR(50), 
    FOREIGN KEY (AccountID) REFERENCES DimAccount(AccountID),
    FOREIGN KEY (BranchID) REFERENCES DimBranch(BranchID)
);

DROP TABLE DimAccount, DimBranch, DimCustomer;
DROP TABLE FactTransaction;