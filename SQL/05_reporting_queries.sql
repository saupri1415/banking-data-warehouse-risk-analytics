-- Monthly Transaction Summary
SELECT 
    D.Year,
    D.Month,
    SUM(F.Amount) AS TotalAmount
FROM FactTransactions F
JOIN DimDate D ON F.DateKey = D.DateKey
GROUP BY D.Year, D.Month;

-- High Risk Customers
SELECT 
    C.CustomerName,
    COUNT(*) AS FraudTransactions
FROM FactTransactions F
JOIN DimCustomer C ON F.CustomerKey = C.CustomerKey
WHERE F.IsFraud = 1
GROUP BY C.CustomerName;
