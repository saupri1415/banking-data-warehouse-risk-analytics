-- ================================
-- DATABASE
-- ================================
CREATE DATABASE BankingDWH;
GO

USE BankingDWH;
GO

-- ================================
-- DIMENSION TABLES
-- ================================

CREATE TABLE DimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    CustomerName VARCHAR(100),
    City VARCHAR(50),
    KYCStatus VARCHAR(20),
    RiskCategory VARCHAR(20),
    EffectiveDate DATE,
    ExpiryDate DATE,
    IsActive BIT
);

CREATE TABLE DimAccount (
    AccountKey INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT,
    AccountType VARCHAR(20),
    BranchID INT
);

CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,
    FullDate DATE,
    Year INT,
    Month INT,
    Day INT
);

-- ================================
-- FACT TABLE
-- ================================

CREATE TABLE FactTransactions (
    TransactionKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerKey INT,
    AccountKey INT,
    DateKey INT,
    Amount DECIMAL(18,2),
    TransactionType VARCHAR(20),
    IsFraud BIT DEFAULT 0,

    FOREIGN KEY (CustomerKey) REFERENCES DimCustomer(CustomerKey),
    FOREIGN KEY (AccountKey) REFERENCES DimAccount(AccountKey),
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey)
);

-- ================================
-- INDEXING (Performance)
-- ================================

CREATE NONCLUSTERED INDEX IX_FactTransactions_CustomerKey 
ON FactTransactions(CustomerKey);

CREATE NONCLUSTERED INDEX IX_FactTransactions_DateKey 
ON FactTransactions(DateKey);
