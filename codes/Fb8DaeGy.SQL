select hash1, count(hash1) 
from
(
  select distinct hash as hash1 from test1
  UNION all
  select distinct hash as hash1 from test3
) a
group by hash1
having count(hash1) = 1
order by count(hash1) desc