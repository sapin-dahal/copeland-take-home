-- For each product ID calculate ave age
SELECT ph.ProductID, AVG(cd.Age) AS avg_age
FROM CustomerPurchaseHistory AS ph
JOIN CustomerDemographics AS cd ON ph.Customer = cd.CustomerID
GROUP BY ph.ProductID
ORDER BY ph.ProductID