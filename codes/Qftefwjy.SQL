select b.hash1, t1.*, t3.* from 
(
    select hash1, count(hash1) as c1
    from
    (
      select distinct hash as hash1 from test1
      UNION all
      select distinct hash as hash1 from test3
    ) a
    group by hash1
    having count(hash1) > 1
    order by count(hash1) desc
) b
join test1 t1 on t1.hash = b.hash1
join test3 t3 on t3.hash = b.hash1