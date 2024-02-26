SELECT 
-- Getting the month and year from PurchaseDate 
	CONCAT(YEAR(PurchaseDate), '-', MONTH(PurchaseDate)) AS purchased_month,
	COUNT(ph.ProductID) AS purchaseCount, 
	SUM(ph.Quantity) quantityPurchased
FROM dbo.CustomerPurchaseHistory AS ph
GROUP BY CONCAT(YEAR(PurchaseDate), '-', MONTH(PurchaseDate))
ORDER BY year_month