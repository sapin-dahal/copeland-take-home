SELECT Customer
FROM CustomerPurchaseHistory AS ph
-- Using INNER JOIN to make sure only get customers that are 
-- available in both CustomerDemographics and CustomerPurchaseHistory tables
JOIN CustomerDemographics AS cd ON ph.Customer = cd.CustomerID
GROUP BY Customer
-- SELECTING customer from Purchase Histroy who has more than 1 transactions
HAVING count(*) > 1
ORDER BY Customer