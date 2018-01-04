SELECT COUNT(*)
FROM
    (SELECT a.name account_name, SUM(o.standard_qty) 
	standard_sum
	FROM accounts a
	JOIN orders o
	ON a.id = o.account_id
	GROUP BY account_name
	ORDER BY standard_sum DESC
	LIMIT 1) most_standard_qty
JOIN
	(SELECT a.name account_name, SUM(o.total) total_sum
     FROM accounts a
     JOIN orders o
     ON a.id = o.account_id
     GROUP BY a.name
     ) total
 ON most_standard_qty.account_name = total.account_name
 HAVING total.total_sum > most_standard_qty.standard_sum