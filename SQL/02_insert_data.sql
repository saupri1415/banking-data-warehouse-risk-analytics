-- Insert DimCustomer (SCD Type 2 Ready)
INSERT INTO DimCustomer 
(CustomerID, CustomerName, City, KYCStatus, RiskCategory, EffectiveDate, ExpiryDate, IsActive)
VALUES
(101, 'Amit Sharma', 'Delhi', 'Verified', 'Low Risk', GETDATE(), NULL, 1),
(102, 'Rahul Verma', 'Mumbai', 'Pending', 'Low Risk', GETDATE(), NULL, 1);

-- Insert DimAccount
INSERT INTO DimAccount (AccountID, AccountType, BranchID)
VALUES
(1001, 'Savings', 1),
(1002, 'Current', 2);

-- Insert DimDate
INSERT INTO DimDate (DateKey, FullDate, Year, Month, Day)
VALUES
(20250101, '2025-01-01', 2025, 1, 1),
(20250102, '2025-01-02', 2025, 1, 2);

-- Insert FactTransactions
INSERT INTO FactTransactions (CustomerKey, AccountKey, DateKey, Amount, TransactionType)
VALUES
(1, 1, 20250101, 150000, 'Credit'),
(1, 1, 20250102, 200000, 'Debit'),
(2, 2, 20250101, 5000, 'Debit');
