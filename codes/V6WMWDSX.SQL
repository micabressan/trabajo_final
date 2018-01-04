select
p.FirstName+' '+p.SecondName+' '+p.ThirdName as name, 
p.TabNum,
l.TranDateTime as date,
d.DeptName,
t.text
from personel p,depart d,TransType t,emails e,TransLog l
where
p.Dep_ID=d.id_dep and
d.id_dep=12 and
t.id=l.TranCode and
e.dept_id=d.id_dep and
l.TranDateTime>dateadd(d,-1,getdate()) and l.TranDateTime<getdate()
order by 1,3,4