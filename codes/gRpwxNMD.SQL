SELECT 
	MONTH(customers.firstOrderDate) as orderMonth,
	YEAR(customers.firstOrderDate) as orderYear,
	COUNT(customers.CustomerId) as repeatCustomers,
	COUNT(cpc.medium) as cpc
FROM((
	(SELECT CustomerId, MIN(ordered) as firstOrderDate, MIN(transactionId) as firstOrderId, SUM(price) as total
	FROM Analytics
	GROUP BY CustomerID) as customers
	INNER JOIN
		(SELECT CustomerID
		FROM Analytics
		GROUP BY CustomerID
		HAVING COUNT(*) > 1) as repeats
	ON customers.customerId = repeats.customerId)
	LEFT JOIN Analytics as cpc
	ON (firstOrderId = cpc.transactionId AND cpc.medium = 'cpc'))
GROUP BY YEAR(firstOrderDate), MONTH(firstOrderDate)
ORDER BY YEAR(firstOrderDate), MONTH(firstOrderDate)