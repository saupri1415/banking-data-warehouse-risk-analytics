-- ================================
-- FRAUD DETECTION LOGIC
-- ================================

-- Rule 1: High value multiple transactions
UPDATE FT
SET IsFraud = 1
FROM FactTransactions FT
JOIN (
    SELECT CustomerKey
    FROM FactTransactions
    WHERE Amount > 100000
    GROUP BY CustomerKey
    HAVING COUNT(*) >= 2
) T
ON FT.CustomerKey = T.CustomerKey;

-- Rule 2: Sudden spike detection
WITH TransactionAvg AS (
    SELECT CustomerKey, AVG(Amount) AS AvgAmount
    FROM FactTransactions
    GROUP BY CustomerKey
)
UPDATE FT
SET IsFraud = 1
FROM FactTransactions FT
JOIN TransactionAvg TA
ON FT.CustomerKey = TA.CustomerKey
WHERE FT.Amount > (TA.AvgAmount * 3);
