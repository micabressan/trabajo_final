//Find selected nodes with degree>20
MATCH (n)
WHERE NOT n:MakeModel
AND NOT n:DateOfBirth
AND NOT n:Pattern
AND NOT n:FullName
WITH n, size((n)-[]-()) as degree
WHERE degree>20
RETURN count(n)