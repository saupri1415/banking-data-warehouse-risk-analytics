-- ================================
-- SCD TYPE 2 IMPLEMENTATION
-- ================================

MERGE DimCustomer AS TARGET
USING (
    SELECT CustomerID, CustomerName, City, KYCStatus
    FROM StagingCustomer
) AS SOURCE
ON TARGET.CustomerID = SOURCE.CustomerID AND TARGET.IsActive = 1

WHEN MATCHED AND 
(
    TARGET.City <> SOURCE.City OR 
    TARGET.KYCStatus <> SOURCE.KYCStatus
)
THEN
-- Expire old record
UPDATE SET 
    TARGET.ExpiryDate = GETDATE(),
    TARGET.IsActive = 0

WHEN NOT MATCHED BY TARGET
THEN
INSERT (CustomerID, CustomerName, City, KYCStatus, RiskCategory, EffectiveDate, IsActive)
VALUES (SOURCE.CustomerID, SOURCE.CustomerName, SOURCE.City, SOURCE.KYCStatus, 'Low Risk', GETDATE(), 1);
