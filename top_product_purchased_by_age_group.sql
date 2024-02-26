-- Calculate Min and MAX age
WITH age_calc AS (
  SELECT MIN(Age) AS youngest, MAX(Age) AS oldest
  FROM CustomerDemographics
),
age_groups AS (
SELECT *,
-- Group each customer into age groups in bin of 10 such as (18-27, 28-37 and such...)
	FLOOR((Age - (SELECT youngest FROM age_calc)) / 10) + 1 AS AgeGroup
FROM CustomerDemographics
)
SELECT 
  p.ProductName,
  t1.AgeGroup,
  t1.TopQuantity AS TopQuantityPurchased
FROM Product AS p
INNER JOIN (
  SELECT 
    ProductID,
    AgeGroup,
	row_num,
    MAX(Quantity) AS TopQuantity
  FROM (
    SELECT 
      t.ProductID,
      ag.AgeGroup,
      t.Quantity,
	  -- Rank based on the total quantity by each product and ageGroup
      ROW_NUMBER() OVER (PARTITION BY ag.AgeGroup ORDER BY t.Quantity DESC) row_num
    FROM CustomerPurchaseHistory AS t
    INNER JOIN age_groups AS ag ON t.Customer = ag.CustomerID
  ) AS ranked_data
  GROUP BY ProductID, AgeGroup, row_num
) AS t1 ON p.ProductID = t1.ProductID
AND t1.row_num = 1
ORDER BY t1.AgeGroup