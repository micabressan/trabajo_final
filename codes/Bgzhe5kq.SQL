SELECT prod_group, max(SELECT sum(qty_on_hand * list_price)
			FROM products
			GROUP BY prod_group)
FROM products
GROUP BY prod_group;