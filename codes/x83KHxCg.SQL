SELECT DISTINCT(k.k_id), k.k_id, k.title 
FROM db.at
LEFT JOIN db.kat ON kat.at_id=at.at_id
LEFT JOIN db.k ON k.k_id = kat.k_id
WHERE at.dd_id=3744
ORDER BY k.title
LIMIT 50